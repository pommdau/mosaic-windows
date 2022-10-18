//
//  ContentView.swift
//  WindowDemo
//
//  Created by HIROKI IKEUCHI on 2022/10/17.
//

import SwiftUI
import AVFAudio

struct GlassBackGround: View {

    let width: CGFloat
    let height: CGFloat
    let color: Color

    var body: some View {
        ZStack{
            RadialGradient(colors: [.clear, color],
                           center: .center,
                           startRadius: 1,
                           endRadius: 100)
                .opacity(0.6)
            Rectangle().foregroundColor(color)
        }
        .opacity(0.2)
        .blur(radius: 2)
        .cornerRadius(10)
        .frame(width: width, height: height)
    }
}

struct ContentView: View {
    
    @State private var windows: [Window] = []
    @State private var timer: Timer? = nil
    
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
                    .foregroundColor(.black.opacity(0.1))
                    .frame(width: window.frame.width, height: window.frame.height)
                    .position(.init(x: window.frame.origin.x + window.frame.width / 2,
                                    y: window.frame.origin.y + window.frame.height / 2 - menuBarHeight * 2))
            }
            
            VStack {
                Button(action: {
//                    updateWindowInfo()
                    for window in windows {
                        print("\(window.windowName): \(window.windowLayer)")
                    }
                }, label: {
                    Text("Print")
                })
                
                Button(action: {
//                    startTimer()
                    updateWindowInfo()
                }, label: {
                    Text("UpdateInfo")
                })
                
            }
        }
        .onAppear() {
            updateWindowInfo()
//            startTimer()
        }
        .onDisappear() {
            stopTimer()
        }
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { _ in
            updateWindowInfo()
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func updateWindowInfo() {
        windows.removeAll()
//        if let windowInfos = CGWindowListCopyWindowInfo([.optionAll], 0) {
        if let windowInfos = CGWindowListCopyWindowInfo([.optionOnScreenOnly], 0) {
            for windowInfo in windowInfos as NSArray {
                if let info = windowInfo as? NSDictionary,
                   let window = Window(with: info) {
                    windows.insert(window, at: windows.endIndex)
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


