//
//  Window.swift
//  MosaicWindows
//
//  Created by HIROKI IKEUCHI on 2022/10/18.
//

import Foundation

struct Window: Identifiable {
    
    let id: Int
    var windowAlpha: Int
    var windowIsOnscreen: Bool
    var windowBounds: CGRect
    var windowLayer: Int
    var windowMemoryUsage: Int
    var windowName: String
    var windowOwnerName: String
    var windowOwnerPID: Int
    var windowSharingState: Int
    var windowStoreType: Int
        
    init(with windowInfo: NSDictionary) {
        self.id = Self.windowNumber(with: windowInfo)
        self.windowAlpha = Self.windowAlpha(with: windowInfo)
        self.windowIsOnscreen = Self.windowIsOnscreen(with: windowInfo)
        self.windowBounds = Self.windowBounds(with: windowInfo)
        self.windowLayer = Self.windowLayer(with: windowInfo)
        self.windowMemoryUsage = Self.windowMemoryUsage(with: windowInfo)
        self.windowName = Self.windowName(with: windowInfo)
        self.windowOwnerName = Self.windowOwnerName(with: windowInfo)
        self.windowOwnerPID = Self.windowOwnerPID(with: windowInfo)
        self.windowSharingState = Self.windowSharingState(with: windowInfo)
        self.windowStoreType = Self.windowStoreType(with: windowInfo)
    }
}

extension Window {
    
    static func windowAlpha(with windowInfo: NSDictionary) -> Int {
        guard let windowAlpha = windowInfo[kCGWindowAlpha as String] as? Int else {
//            fatalError()  // なんか取れない場合がある
            return 0
        }
        return windowAlpha
    }
    
    static func windowIsOnscreen(with windowInfo: NSDictionary) -> Bool {
        guard let windowIsOnscreen = windowInfo[kCGWindowIsOnscreen as String] as? Bool else {
            fatalError()
        }
        return windowIsOnscreen
    }
    
    static func windowBounds(with windowInfo: NSDictionary) -> CGRect {
        let _windowBounds: CFDictionary = windowInfo[kCGWindowBounds as String] as! CFDictionary
        guard let windowBounds = CGRect(dictionaryRepresentation: _windowBounds) else {
            fatalError()
        }
        return windowBounds
    }
    
    static func windowLayer(with windowInfo: NSDictionary) -> Int {
        guard let windowLayer = windowInfo[kCGWindowLayer as String] as? Int else {
            return 0
        }
        return windowLayer
    }
    
    static func windowMemoryUsage(with windowInfo: NSDictionary) -> Int {
        guard let windowMemoryUsage = windowInfo[kCGWindowMemoryUsage as String] as? Int else {
            fatalError()
        }
        return windowMemoryUsage
    }
    
    static func windowName(with windowInfo: NSDictionary) -> String {
        guard let windowName = windowInfo[kCGWindowName as String] as? String else {
            return ""  // 権限がない場合に取得できない
        }
        return windowName
    }
    
    static func windowNumber(with windowInfo: NSDictionary) -> Int {
        guard let windowNumber = windowInfo[kCGWindowNumber as String] as? Int else {
            fatalError()
        }
        return windowNumber
    }
    
    static func windowOwnerName(with windowInfo: NSDictionary) -> String {
        guard let windowOwnerName = windowInfo[kCGWindowOwnerName as String] as? String else {
            fatalError()
        }
        return windowOwnerName
    }
    
    static func windowOwnerPID(with windowInfo: NSDictionary) -> Int {
        guard let windowOwnerPID = windowInfo[kCGWindowOwnerPID as String] as? Int else {
            fatalError()
        }
        return windowOwnerPID
    }
    
    static func windowSharingState(with windowInfo: NSDictionary) -> Int {
        guard let windowSharingState = windowInfo[kCGWindowSharingState as String] as? Int else {
            fatalError()
        }
        return windowSharingState
    }
    
    static func windowStoreType(with windowInfo: NSDictionary) -> Int {
        guard let windowStoreType = windowInfo[kCGWindowStoreType as String] as? Int else {
            fatalError()
        }
        return windowStoreType
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
windowNumber = \(id)
windowOwnerName = \(windowOwnerName)
windowOwnerPID = \(windowOwnerPID)
windowSharingState = \(windowSharingState)
windowStoreType = \(windowStoreType)
"""
    }
    
}
