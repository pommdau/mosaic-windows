//
//  Window.swift
//  WindowDemo
//
//  Created by HIROKI IKEUCHI on 2022/10/17.
//

import Foundation

struct Window: Identifiable {
    
    fileprivate(set) var id: UUID = UUID()
    fileprivate(set) var windowId: CGWindowID
    fileprivate(set) var name: String
    fileprivate(set) var windowName: String
    fileprivate(set) var frame: CGRect
    fileprivate(set) var windowLayer: Int
    
    init?(with windowInfo: NSDictionary) {
        let _windowAlpha = windowInfo[Window.convert(CFString: kCGWindowAlpha)]
        let windowAlpha = _windowAlpha != nil ? (_windowAlpha as! NSNumber).intValue : 0

        let _windowBounds = windowInfo[Window.convert(CFString: kCGWindowBounds)]
        let windowBounds = _windowBounds != nil ? CGRect(dictionaryRepresentation: _windowBounds as! CFDictionary) ?? .zero : .zero

        let _ownerName = windowInfo[Window.convert(CFString: kCGWindowOwnerName)]
        let ownerName = _ownerName != nil ? Window.convert(CFString: _ownerName as! CFString) : ""  // CFString -> Stringの変換？
        
        let _windowId = windowInfo[Window.convert(CFString: kCGWindowNumber)]
        let windowId = _windowId != nil ? Window.convertToCGWindowId(CFNumber: _windowId as! CFNumber) : 0
        
        let _windowName = windowInfo[Window.convert(CFString: kCGWindowName)]
        let windowName = _windowName != nil ? Window.convert(CFString: _windowName as! CFString) : ""
        
        let _windowIsOnscreen = windowInfo[Window.convert(CFString: kCGWindowIsOnscreen)]
        let windowIsOnscreen = _windowIsOnscreen != nil ? Window.convert(CFBoolean: _windowIsOnscreen as! CFBoolean) : false
        
        let _windowLayer = windowInfo[Window.convert(CFString: kCGWindowLayer)]
        let windowLayer = _windowLayer != nil ? Window.convert(CFNumber: _windowLayer as! CFNumber) : -99
        
        guard
            windowAlpha > 0,
            windowBounds.width > 10,
            windowBounds.height > 10,
//            ownerName == "CotEditor.app" || ownerName == "Xcode" ,  // DEBUGGING
            ownerName == "CotEditor.app",
            ownerName != "Dock",
            ownerName != "Window Server",
            windowIsOnscreen
        else {
            return nil
        }
        
        self.windowId = windowId
        self.name = ownerName
        self.windowName = windowName
        self.frame = windowBounds
        self.windowLayer = windowLayer
    }
    
    static func convert(CFString: CFString) -> String {
        return CFString as String
    }
    
    static func convertToCGWindowId(CFNumber: CFNumber) -> CGWindowID {
        return CFNumber as! CGWindowID
    }
    
    static func convert(CFNumber: CFNumber) -> Int {
        return CFNumber as! Int
    }
    
    static func convert(CFBoolean: CFBoolean) -> Bool {
        return CFBoolean as! Bool
    }
}
