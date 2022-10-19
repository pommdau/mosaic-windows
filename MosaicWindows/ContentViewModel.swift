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
    
    // 他のウインドウに覆われていないかどうか
    private func isNotCoverdWindow(withWindow targetWindow: Window, in windows: [Window]) -> Bool {
        for window in windows {
            if window.windowBounds.contains(targetWindow.windowBounds) {
                return false
            }
        }
        
        return true
    }
    
    func updateWindows() {
        let _newWindows = WindowsManager.shared.loadWindowsInfo()
        var newWindows = [Window]()
        for _newWindow in _newWindows {
            if isNotCoverdWindow(withWindow: _newWindow, in: newWindows) {
                newWindows.append(_newWindow)
            }
        }
        
        if newWindows == windows {
            return
        }
        windows = newWindows
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
