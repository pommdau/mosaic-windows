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
        guard let windowAlpha = windowInfo[kCGWindowAlpha as String] as? Int else {
            fatalError()
        }
        return windowAlpha
    }
    
    var windowIsOnscreen: Bool {
        guard let windowIsOnscreen = windowInfo[kCGWindowIsOnscreen as String] as? Bool else {
            fatalError()
        }
        return windowIsOnscreen
    }
    
    var windowBounds: CGRect {
        let _windowBounds: CFDictionary = windowInfo[kCGWindowBounds as String] as! CFDictionary
        guard let windowBounds = CGRect(dictionaryRepresentation: _windowBounds) else {
            fatalError()
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
            fatalError()
        }
        return windowMemoryUsage
    }
    
    var windowName: String {
        guard let windowName = windowInfo[kCGWindowName as String] as? String else {
            return ""  // 権限がない場合に取得できない
        }
        return windowName
    }
    
    var windowNumber: Int {
        guard let windowNumber = windowInfo[kCGWindowNumber as String] as? Int else {
            fatalError()
        }
        return windowNumber
    }
    
    var windowOwnerName: String {
        guard let windowOwnerName = windowInfo[kCGWindowOwnerName as String] as? String else {
            fatalError()
        }
        return windowOwnerName
    }
    
    var windowOwnerPID: Int {
        guard let windowOwnerPID = windowInfo[kCGWindowOwnerPID as String] as? Int else {
            fatalError()
        }
        return windowOwnerPID
    }
    
    var windowSharingState: Int {
        guard let windowSharingState = windowInfo[kCGWindowSharingState as String] as? Int else {
            fatalError()
        }
        return windowSharingState
    }
    
    var windowStoreType: Int {
        guard let windowStoreType = windowInfo[kCGWindowStoreType as String] as? Int else {
            fatalError()
        }
        return windowStoreType
    }
    
    init(with windowInfo: NSDictionary) {
        self.windowInfo = windowInfo
        // TODO: id
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
