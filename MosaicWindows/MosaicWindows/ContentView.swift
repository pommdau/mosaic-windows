//
//  ContentView.swift
//  MosaicWindows
//
//  Created by HIROKI IKEUCHI on 2022/10/18.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel: ContentViewModel = .init()
    
    private var menuBarHeight: CGFloat {
        guard let menuBarHeight = NSApplication.shared.mainMenu?.menuBarHeight else {
            return 0
        }
        return menuBarHeight - 4  // 謎のマージン。メニューバーの高さの補間自体が怪しい可能性も…。
    }
    
    var body: some View {
        ZStack {
            MosaicViews()
            DebugButtons()
        }
        .onAppear() {
//            viewModel.startTimer()
            viewModel.updateWindows()
        }
        .onDisappear() {
//            viewModel.stopTimer()
        }
    }
    
    
    
    @ViewBuilder
    private func MosaicViews() -> some View {
        ForEach(viewModel.windows) { window in
            let windowBounds = window.windowBounds
            Rectangle()
                .foregroundColor(.black.opacity(0.2))
                .frame(width: windowBounds.width, height: windowBounds.height)
                .position(.init(x: windowBounds.origin.x + windowBounds.width / 2,
                                y: windowBounds.origin.y + windowBounds.height / 2 - menuBarHeight * 2))
        }
    }
    
    @ViewBuilder
    private func DebugButtons() -> some View {
        VStack {
            Button("Update windows") {
                viewModel.updateWindows()
            }
            
            Button("Print Info") {
                for window in viewModel.windows {
                    print(window.ikehDebugDescription)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
