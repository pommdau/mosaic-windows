//
//  WindowsManager.swift
//  MosaicWindows
//
//  Created by HIROKI IKEUCHI on 2022/10/18.
//

import Foundation

struct WindowsManager {
    
    static let shared: WindowsManager = .init()
        
    func loadWindowsInfo() -> [Window] {
        
        CGRequestScreenCaptureAccess()
        
        var windows = [Window]()
        
        guard let windowsInfo = CGWindowListCopyWindowInfo([.optionOnScreenOnly], 0) else {
            return []
        }
        
        for _windowInfo in windowsInfo as NSArray {
            guard let windowInfo = _windowInfo as? NSDictionary else {
                continue
            }
            
            let window = Window(with: windowInfo)
            guard isTarget(withWindow: window) else {
                continue
            }
            windows.insert(window, at: windows.endIndex)
        }
        
        return windows
    }
    
    private func isTarget(withWindow window: Window) -> Bool {
        guard
            window.windowAlpha > 0,
            window.windowBounds.width > 10, window.windowBounds.height > 10,
            window.windowOwnerName == "CotEditor.app",  // Debugging
//            (window.windowOwnerName == "CotEditor.app" || window.windowOwnerName == "TweetComment"),  // Debugging
            window.windowOwnerName != "Dock",
            window.windowOwnerName != "Window Server",
            window.windowIsOnscreen
        else {
            return false
        }
        
        return true
    }
}
