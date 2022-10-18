//
//  ContentView.swift
//  MosaicWindows
//
//  Created by HIROKI IKEUCHI on 2022/10/18.
//

import SwiftUI

struct ContentView: View {
    
    @State private var windows: [Window] = []
    
    var body: some View {
        VStack {
            Button("Get Info") {
                windows = WindowsManager.shared.loadWindowsInfo()
            }
            
            Button("Print Info") {
                for window in windows {
                    print(window.ikehDebugDescription)
                }
            }
        }
        .onAppear() {
            windows = WindowsManager.shared.loadWindowsInfo()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
