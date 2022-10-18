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
                windows.removeAll()
                if let windowInfos = CGWindowListCopyWindowInfo([.optionOnScreenOnly], 0) {
                    for windowInfo in windowInfos as NSArray {
                        if let info = windowInfo as? NSDictionary {
                            let window = Window(with: info)
                            print(window.ikehDebugDescription)
                            windows.insert(window, at: windows.endIndex)
                        }
                    }
                }
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
