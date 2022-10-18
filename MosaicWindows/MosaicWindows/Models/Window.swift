//
//  Window.swift
//  MosaicWindows
//
//  Created by HIROKI IKEUCHI on 2022/10/18.
//

import Foundation

struct Window: Identifiable {
    
    let id: UUID = UUID()
    private var windowInfo: NSDictionary
    
    var windowAlpha: Int {
        guard let windowAlpha = windowInfo[kCGWindowOwnerName as String] as? Int else {
            return 0
        }
        return windowAlpha
    }
    
    var windowIsOnscreen: Bool {
        guard let windowIsOnscreen = windowInfo[kCGWindowIsOnscreen as String] as? Bool else {
            return false
        }
        return windowIsOnscreen
    }
    
    var windowBounds: CGRect {
        let _windowBounds: CFDictionary = windowInfo[kCGWindowBounds as String] as! CFDictionary
        guard let windowBounds = CGRect(dictionaryRepresentation: _windowBounds) else {
            return .zero
        }
        return windowBounds
    }
    
    var windowLayer: Int {
        guard let windowLayer = windowInfo[kCGWindowLayer as String] as? Int else {
            return 0
        }
        return windowLayer
    }
    
    var windowMemoryUsage: Int {
        guard let windowMemoryUsage = windowInfo[kCGWindowMemoryUsage as String] as? Int else {
            return 0
        }
        return windowMemoryUsage
    }
    
    var windowName: String {
        guard let windowName = windowInfo[kCGWindowName as String] as? String else {
            return ""
        }
        return windowName
    }
    
    var windowNumber: Int {
        guard let windowNumber = windowInfo[kCGWindowNumber as String] as? Int else {
            return 0
        }
        return windowNumber
    }
    
    var windowOwnerName: String {
        guard let windowOwnerName = windowInfo[kCGWindowOwnerName as String] as? String else {
            return ""
        }
        return windowOwnerName
    }
    
    var windowOwnerPID: Int {
        guard let windowOwnerPID = windowInfo[kCGWindowOwnerPID as String] as? Int else {
            return 0
        }
        return windowOwnerPID
    }
    
    var windowSharingState: Int {
        guard let windowSharingState = windowInfo[kCGWindowSharingState as String] as? Int else {
            return 0
        }
        return windowSharingState
    }
    
    var windowStoreType: Int {
        guard let windowStoreType = windowInfo[kCGWindowStoreType as String] as? Int else {
            return 0
        }
        return windowStoreType
    }
    
    init(with windowInfo: NSDictionary) {
        self.windowInfo = windowInfo
    }
}

extension Window {
    
    var ikehDebugDescription: String {
        return """
windowAlpha = \(windowAlpha)
windowIsOnscreen = \(windowIsOnscreen)
windowBounds = \(windowBounds)
windowLayer = \(windowLayer)
windowMemoryUsage = \(windowMemoryUsage)
windowName = \(windowName)
windowNumber = \(windowNumber)
windowOwnerName = \(windowOwnerName)
windowOwnerPID = \(windowOwnerPID)
windowSharingState = \(windowSharingState)
windowStoreType = \(windowStoreType)

"""
    }
    
}
