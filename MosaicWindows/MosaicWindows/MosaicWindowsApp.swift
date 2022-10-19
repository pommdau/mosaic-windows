//
//  MosaicWindowsApp.swift
//  MosaicWindows
//
//  Created by HIROKI IKEUCHI on 2022/10/18.
//

import SwiftUI

@main
struct MosaicWindowsApp: App {
    
    @State var mainScreenSize: CGSize = .zero
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(width: mainScreenSize.width,
                       height: mainScreenSize.height)
                .position(x: mainScreenSize.width / 2,
                          y: mainScreenSize.height / 2)
                .navigationTitle("MosaicWindows")
                .onReceive(NotificationCenter.default.publisher(for: NSApplication.didBecomeActiveNotification)) { _ in
                    guard let window = NSApp.mainWindow else {
                        return
                    }
                    
                    window.standardWindowButton(.zoomButton)?.isHidden = true
                    window.standardWindowButton(.closeButton)?.isHidden = true
                    window.standardWindowButton(.miniaturizeButton)?.isHidden = true
                    
                    window.titleVisibility = .hidden
                    window.titlebarAppearsTransparent = true
                    
                    window.level = .screenSaver
                    window.ignoresMouseEvents = true
                    
                    window.isOpaque = true
                    window.hasShadow = false
//                    window.backgroundColor = NSColor(.blue).withAlphaComponent(0.5)
                    window.backgroundColor = NSColor(.blue).withAlphaComponent(0.01)
                    
                    for (i, screen) in NSScreen.screens.enumerated() {
                        if i == 0 {
                            mainScreenSize = screen.frame.size
                            window.setContentSize(mainScreenSize)
//                            window.setFrameOrigin(.init(x: .zero,
//                                                        y: screen.frame.size.height))
                            window.setFrameOrigin(.init(x: .zero,
                                                        y: mainScreenSize.height))
                            print(mainScreenSize)
                        }
                    }
                }
        }
    }
}
