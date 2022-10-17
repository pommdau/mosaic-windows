import SwiftUI

@main
struct WindowDemoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(minWidth: 200, minHeight: 200)
                .navigationTitle("Undecorated")                            
        }
    }
}
