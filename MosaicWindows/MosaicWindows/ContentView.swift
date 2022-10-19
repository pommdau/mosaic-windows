//
//  ContentView.swift
//  MosaicWindows
//
//  Created by HIROKI IKEUCHI on 2022/10/18.
//

import SwiftUI

struct ContentView: View {
    
    @State private var windows: [Window] = []
    @State private var timer: Timer? = nil
    
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
            startTimer()
        }
        .onDisappear() {
            stopTimer()
        }
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1/30, repeats: true) { _ in
            updateWindows()
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func updateWindows() {
        windows = WindowsManager.shared.loadWindowsInfo()
    }
    
    @ViewBuilder
    private func MosaicViews() -> some View {
        ForEach(windows) { window in
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
            Button("Get Info") {
                updateWindows()
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
