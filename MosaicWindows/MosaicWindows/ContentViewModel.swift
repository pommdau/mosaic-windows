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
    
    func updateWindows() {
        windows = WindowsManager.shared.loadWindowsInfo()
    }
}
