//
//  DSDeviceKit.swift
//  Pods
//
//  Created by Dmitry Sokolov on 6/30/16.
//
//

public class DSDeviceKit {
    
    // MARK: - Static
    
    public static let currentDevice: DSDeviceKit = {
        return DSDeviceKit.getDeviceInfo()
    }()
    
    // MARK: - Properties
    
    /**
     Enum for the type of the device.
     
     Can be
     - iPhone
     - iPod Touch
     - iPad
     - Unknown
     */
    public enum DeviceType: String, CustomStringConvertible {
        case iPhone = "iPhone"
        case iPodTouch = "iPod Touch"
        case iPad = "iPad"
        case Unknown = "Unknown"
        
        public var description: String {
            return self.rawValue
        }
    }
    
    /**
     Type of the device.
     e.g.
     - iPhone
     - iPod Touch
     - iPad
     - Unknown
     */
    public let deviceType: DeviceType
    
    
    /**
     Model of the device.
     e.g.
     - iPhone 6s
     - iPod Touch 6
     - iPad Pro
     */
    public let modelName: String
    
    
    /**
     Version of installed iOS on the device.
     e.g.
     - iOS 9
     - iOS 8
     - ...
     */
    public let iOSVersion: String
    
    
    
    /**
     Identifier of the device
     e.g.
     - iPhone6,1
     - iPod7,1
     - iPad5,4
     - ...
     */
    public let identifier: String
    
    
    /**
     Check if current device is iPhone
     
     - returns: True if it is iPhone. Otherwise, false
     */
    public var isPhone: Bool {
        get {
            switch self.deviceType {
            case .iPodTouch: fallthrough
            case .iPhone: return true
            default:
                return false
            }
        }
    }
    
    
    /**
     Check if the current device is iPad
     
     - returns: True if it is iPad. Otherwise, false
     */
    public var isIPad: Bool {
        get {
            return self.deviceType == .iPad
        }
    }
    
    
    /**
     Get orientation of the device
     
     ! Can possible return 0/Unknown since accelerometer may been off
     
     - returns: UIDeviceOrientation enum value
     */
    public var orientation: UIDeviceOrientation {
        get {
            UIDevice.currentDevice().beginGeneratingDeviceOrientationNotifications()
            let _orientation = UIDevice.currentDevice().orientation
            UIDevice.currentDevice().endGeneratingDeviceOrientationNotifications()
            return _orientation
        }
    }
    
    
    /**
     Get the userInterface of the device
     
     - returns: UIUserInterfaceIdiom enum value
     */
    public var userInterface: UIUserInterfaceIdiom {
        get {
            return UIDevice.currentDevice().userInterfaceIdiom
        }
    }
    
    // MARK: - Methods
    
    /**
     Private Init
     */
    private init(devType: DeviceType, iosVer: String, modelName: String, identifier: String) {
        self.deviceType = devType
        self.iOSVersion = iosVer
        self.modelName = modelName
        self.identifier = identifier
    }
    
    
    /**
     Get current device information by calling system methods and create an instance of DSDeviceKit
     
     - returns: DSDeviceKit instance
     */
    private class func getDeviceInfo() -> DSDeviceKit {
        
        let devType = UIDevice.currentDevice().model
        let devIOSVer = UIDevice.currentDevice().systemVersion
        var type = DeviceType.Unknown
        
        
        switch devType {
        case "iPhone":
            type = .iPhone
        case "iPod Touch":
            type = .iPodTouch
        case "iPad":
            type = .iPad
        default:
            type = .Unknown
        }
        
        
        var sysInfo = utsname()
        
        uname(&sysInfo)
        let mirror = Mirror(reflecting: sysInfo.machine)
        
        let mirrorIdentifier = mirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8 where value != 0 else { return identifier}
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        var id = ""
        
        switch mirrorIdentifier {
            
        case "iPod5,1":                                     id = "iPod Touch 5"
        case "iPod7,1":                                     id = "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone 3,3":        id = "iPhone 4"
        case "iPhone4,1":                                   id = "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                      id = "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                      id = "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                      id = "iPhone 5s"
        case "iPhone7,2":                                   id = "iPhone 6"
        case "iPhone7,1":                                   id = "iPhone 6 Plus"
        case "iPhone8,1":                                   id = "iPhone 6s"
        case "iPhone8,2":                                   id = "iPhone 6s Plus"
        case "iPhone8,4":                                   id = "iPhone SE"
            
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":    id = "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":               id = "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":               id = "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":               id = "iPad Air"
        case "iPad5,3", "iPad5,4":                          id = "iPad Air 2"
        case "iPad2,5", "iPad2,6", "iPad2,7":               id = "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":               id = "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":               id = "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                          id = "iPad Mini 4"
        case "iPad6,3", "iPad6,4", "iPad6,7", "iPad6,8":    id = "iPad Pro"
        case "AppleTV5,3":                                  id = "Apple TV"
        case "i386", "x86_64":                              id = "Simulator"
            
        default:                                            id = ""
        }
        
        
        let devKit = DSDeviceKit(devType: type, iosVer: devIOSVer, modelName: id, identifier: mirrorIdentifier)
        
        return devKit
        
    }
    
    
    
    /**
     Check if the current device is in the array of given device models
     
     - parameter devices: Array of Strings (case insensitive) which consist of possible device models (e.g. "iPhone 6s", "ipad pro")
     
     - returns: True if the current device is one of the given array. Otherwise, false
     */
    public func isOneOf(devices: [String]) -> Bool {
        
        let _model = self.modelName.lowercaseString.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
        if devices.contains(
            
            {(dev: String) in
                return dev.lowercaseString.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()) == _model
        }) {
            return true
        }
        
        return false
    }
    
    
    
}




extension DSDeviceKit: CustomStringConvertible {
    
    // description for print method
    public var description: String {
        return self.modelName
    }
    
}








