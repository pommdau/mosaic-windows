import SwiftUI

@main
struct WindowDemoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(minWidth: 200, minHeight: 200)
                .navigationTitle("Undecorated")
                .onReceive(NotificationCenter.default.publisher(for: NSApplication.didBecomeActiveNotification)) { _ in
                    guard let window = NSApp.mainWindow else {
                        return
                    }
                    
                    window.standardWindowButton(.zoomButton)?.isHidden = true
                    window.standardWindowButton(.closeButton)?.isHidden = true
                    window.standardWindowButton(.miniaturizeButton)?.isHidden = true
                    
//                    window.titleVisibility = .hidden
                    window.titlebarAppearsTransparent = true
                    
//                    window.level = .screenSaver
//                    window.ignoresMouseEvents = true
                    
                    window.isOpaque = true
                    window.hasShadow = false
//                    window.backgroundColor = NSColor(.blue).withAlphaComponent(0.2)
                    window.backgroundColor = NSColor(.blue).withAlphaComponent(0.01)
                    
                }
        }
    }
}
