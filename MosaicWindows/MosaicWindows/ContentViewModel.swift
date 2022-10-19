//
//  ContentViewModel.swift
//  MosaicWindows
//
//  Created by HIROKI IKEUCHI on 2022/10/19.
//

import Foundation

@MainActor
final class ContentViewModel: ObservableObject {
    @Published var windows: [Window] = []
    private var timer: Timer? = nil
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1/30, repeats: true) { _ in
            self.updateWindows()
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func addWindow(targetWindow: Window, in windows: [Window]) -> [Window] {
        for window in windows {
            if window.windowBounds.contains(targetWindow.windowBounds) {
                return windows
            }
        }
        
        return windows + [targetWindow]
    }
    
    func updateWindows() {
//        windows = WindowsManager.shared.loadWindowsInfo()
        let _newWindows = WindowsManager.shared.loadWindowsInfo()
        var newWindows = [Window]()
        for _newWindow in _newWindows {
            newWindows = addWindow(targetWindow: _newWindow, in: newWindows)
        }
        
        if newWindows == windows {
            print("no change")
            return
        } else {
            print("window changed!")
            windows = newWindows
        }
//
//        newWindows.forEach { newWindow in
//            if let currentWindowIndex = windows.firstIndex(where: { $0.id == newWindow.id }) {
//                // すでにWindowがある場合はBoundsのみを更新する
//                windows[currentWindowIndex].windowBounds = newWindow.windowBounds
//            } else {
//
//            }
//        }
    }
}
