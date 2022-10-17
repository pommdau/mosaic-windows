//
//  ContentView.swift
//  WindowDemo
//
//  Created by HIROKI IKEUCHI on 2022/10/17.
//

import SwiftUI
import AVFAudio

struct ContentView: View {
    
    @State private var windows: [Window] = []
    
    var menuBarHeight: CGFloat {
        guard let menuBarHeight = NSApplication.shared.mainMenu?.menuBarHeight else {
            return 0
        }
        
        return menuBarHeight - 4  // 謎のマージン。メニューバーの高さの補間自体が怪しい可能性も…。
    }
    
    var body: some View {
        
        ZStack {
            
            ForEach(windows) { window in
                Rectangle()
                    .foregroundColor(.red.opacity(0.3))
                    .frame(width: window.frame.width, height: window.frame.height)
                    .position(.init(x: window.frame.origin.x + window.frame.width / 2,
                                    y: window.frame.origin.y + window.frame.height / 2 - menuBarHeight * 2))
            }
            
            VStack {
                Button(action: {
                    getWindowInfo()
                }, label: {
                    Text("Debugging")
                })
                .onAppear() {
                    getWindowInfo()
                }
                
                Button(action: {
//                    print(windows.first?.frame)
                }, label: {
                    Text("ShowInfo")
                })
                
            }
        }
        
    }
    
    private func getWindowInfo() {
        
        //            windows.removeAll()
        if let windowInfos = CGWindowListCopyWindowInfo([.optionAll], 0) {
            for windowInfo in windowInfos as NSArray {
                if let info = windowInfo as? NSDictionary,
                               let window = Window(with: info) {
                    print(info)
                    windows.append(window)
                }
            }
        }
    }
    
    private func copyAttributeValue(_ element: AXUIElement, attribute: String) -> CFTypeRef? {
        var ref: CFTypeRef? = nil
        let error = AXUIElementCopyAttributeValue(element, attribute as CFString, &ref)
        if error == .success {
            return ref
        }
        return .none
    }
    
    private func getFocusedWindow(pid: pid_t) -> AXUIElement? {
        let element = AXUIElementCreateApplication(pid)
        if let window = self.copyAttributeValue(element, attribute: kAXFocusedWindowAttribute) {
            return (window as! AXUIElement)
        }
        return nil
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct Window: Identifiable {
    
    fileprivate(set) var id: CGWindowID = 0
    fileprivate(set) var name: String!
    fileprivate(set) var frame: CGRect!
    fileprivate(set) var image: NSImage!
    
    
    init?(with windowInfo: NSDictionary) {
        let windowAlpha = windowInfo[Window.convert(CFString: kCGWindowAlpha)]
        let alpha = windowAlpha != nil ? (windowAlpha as! NSNumber).intValue : 0
        let windowBounds = windowInfo[Window.convert(CFString: kCGWindowBounds)]
        let bounds = windowBounds != nil ? CGRect(dictionaryRepresentation: windowBounds as! CFDictionary) ?? .zero : .zero
        let ownerName = windowInfo[Window.convert(CFString: kCGWindowOwnerName)]
        let name = ownerName != nil ? Window.convert(CFString: ownerName as! CFString) : ""  // CFString -> Stringの変換？
        let windowId = windowInfo[Window.convert(CFString: kCGWindowNumber)]
        let id = windowId != nil ? Window.convert(CFNumber: windowId as! CFNumber) : 0
        let image = NSImage.windowImage(with: id)
        
        guard
            alpha > 0,
            bounds.width > 100,
            bounds.height > 100,
            image.size.width > 1,
            image.size.height > 1,
            name == "CotEditor.app",  // DEBUGGING
            name != "Dock",
            name != "Window Server" else {
            return nil
        }
        
        self.id = id
        self.name = name
        self.frame = bounds
        self.image = image
    }
    
    static func convert(CFString: CFString) -> String {
        return CFString as String
    }
    
    static func convert(CFNumber: CFNumber) -> CGWindowID {
        return CFNumber as! CGWindowID
    }
}

private extension NSImage {
    class func windowImage(with windowId: CGWindowID) -> NSImage {
        if let screenShot = CGWindowListCreateImage(CGRect.null, .optionIncludingWindow, CGWindowID(windowId), CGWindowImageOption()) {
            let bitmapRep = NSBitmapImageRep(cgImage: screenShot)
            let image = NSImage()
            image.addRepresentation(bitmapRep)
            return image
        } else {
            return NSImage()
        }
    }
}
