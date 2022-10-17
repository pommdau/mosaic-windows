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
                    
                    if let window = windows.first {
                        print(window.frame)
                        print(window.windowName)
                    }
                }, label: {
                    Text("ShowInfo")
                })
                
            }
        }
        
    }
    
    private func getWindowInfo() {
        
        windows.removeAll()
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
    
//    private func copyAttributeValue(_ element: AXUIElement, attribute: String) -> CFTypeRef? {
//        var ref: CFTypeRef? = nil
//        let error = AXUIElementCopyAttributeValue(element, attribute as CFString, &ref)
//        if error == .success {
//            return ref
//        }
//        return .none
//    }
//
//    private func getFocusedWindow(pid: pid_t) -> AXUIElement? {
//        let element = AXUIElementCreateApplication(pid)
//        if let window = self.copyAttributeValue(element, attribute: kAXFocusedWindowAttribute) {
//            return (window as! AXUIElement)
//        }
//        return nil
//    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct Window: Identifiable {
    
    fileprivate(set) var id: UUID = UUID()
    fileprivate(set) var windowId: CGWindowID
    fileprivate(set) var name: String
    fileprivate(set) var windowName: String
    fileprivate(set) var frame: CGRect
    
    init?(with windowInfo: NSDictionary) {
        let _windowAlpha = windowInfo[Window.convert(CFString: kCGWindowAlpha)]
        let windowAlpha = _windowAlpha != nil ? (_windowAlpha as! NSNumber).intValue : 0

        let _windowBounds = windowInfo[Window.convert(CFString: kCGWindowBounds)]
        let windowBounds = _windowBounds != nil ? CGRect(dictionaryRepresentation: _windowBounds as! CFDictionary) ?? .zero : .zero

        let _ownerName = windowInfo[Window.convert(CFString: kCGWindowOwnerName)]
        let ownerName = _ownerName != nil ? Window.convert(CFString: _ownerName as! CFString) : ""  // CFString -> Stringの変換？
        
        let _windowId = windowInfo[Window.convert(CFString: kCGWindowNumber)]
        let windowId = _windowId != nil ? Window.convert(CFNumber: _windowId as! CFNumber) : 0
        
        let _windowName = windowInfo[Window.convert(CFString: kCGWindowName)]
        let windowName = _windowName != nil ? Window.convert(CFString: _windowName as! CFString) : ""
        
        let _windowIsOnscreen = windowInfo[Window.convert(CFString: kCGWindowIsOnscreen)]
        let windowIsOnscreen = _windowIsOnscreen != nil ? Window.convert(CFBoolean: _windowIsOnscreen as! CFBoolean) : false
        
        guard
            windowAlpha > 0,
            windowBounds.width > 10,
            windowBounds.height > 10,
            ownerName == "CotEditor.app",  // DEBUGGING
            ownerName != "Dock",
            ownerName != "Window Server",
            windowIsOnscreen
        else {
            return nil
        }
        
        self.windowId = windowId
        self.name = ownerName
        self.windowName = windowName
        self.frame = windowBounds
    }
    
    static func convert(CFString: CFString) -> String {
        return CFString as String
    }
    
    static func convert(CFNumber: CFNumber) -> CGWindowID {
        return CFNumber as! CGWindowID
    }
    
    static func convert(CFBoolean: CFBoolean) -> Bool {
        return CFBoolean as! Bool
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
