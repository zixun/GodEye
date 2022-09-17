//
//  Hardware.swift
//  Pods
//
//  Created by zixun on 17/1/20.
//
//

import Foundation

open class Hardware: NSObject {
    
    //--------------------------------------------------------------------------
    // MARK: OPEN PROPERTY
    //--------------------------------------------------------------------------
    
    /// System uptime, you can get the components from the result
    public static var uptime: Date {
        get {
            /// get the info about the process
            let processsInfo = ProcessInfo.processInfo
            /// get the uptime of the system
            let timeInterval = processsInfo.systemUptime
            /// create and return the date
            return Date(timeIntervalSinceNow: -timeInterval)
        }
    }
    /// model of the device, eg: "iPhone", "iPod touch"
    public static let deviceModel: String = UIDevice.current.model
    /// name of the device, eg: "My iPhone"
    public static var deviceName: String = UIDevice.current.name
    /// system name of the device, eg: "iOS"
    public static let systemName: String = UIDevice.current.systemName
    /// system version of the device, eg: "10.0"
    public static let systemVersion: String = UIDevice.current.systemVersion
    /// version code of device, eg: "iPhone7,1"
    public static var deviceVersionCode: String {
        get {
            var systemInfo = utsname()
            uname(&systemInfo)
            
            let versionCode: String = String(validatingUTF8: NSString(bytes: &systemInfo.machine, length: Int(_SYS_NAMELEN), encoding: String.Encoding.ascii.rawValue)!.utf8String!)!
            
            return versionCode
        }
    }
    /// version of device, eg: "iPhone5"
    public static var deviceVersion: String {
        get {
            switch self.deviceVersionCode {
            /*** iPhone ***/
            case "iPhone3,1", "iPhone3,2", "iPhone3,3":      return "iPhone4"
            case "iPhone4,1", "iPhone4,2", "iPhone4,3":      return "iPhone4S"
            case "iPhone5,1", "iPhone5,2":                   return "iPhone5"
            case "iPhone5,3", "iPhone5,4":                   return "iPhone5C"
            case "iPhone6,1", "iPhone6,2":                   return "iPhone5S"
            case "iPhone7,2":                                return "iPhone6"
            case "iPhone7,1":                                return "iPhone6Plus"
            case "iPhone8,1":                                return "iPhone6S"
            case "iPhone8,2":                                return "iPhone6SPlus"
            case "iPhone8,4":                                return "iPhoneSE"
            case "iPhone9,1", "iPhone9,3":                   return "iPhone7"
            case "iPhone9,2", "iPhone9,4":                   return "iPhone7Plus"
                
            /*** iPad ***/
            case "iPad1,1":                                  return "iPad1"
            case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4": return "iPad2"
            case "iPad3,1", "iPad3,2", "iPad3,3":            return "iPad3"
            case "iPad3,4", "iPad3,5", "iPad3,6":            return "iPad4"
            case "iPad4,1", "iPad4,2", "iPad4,3":            return "iPadAir"
            case "iPad5,3", "iPad5,4":                       return "iPadAir2"
            case "iPad2,5", "iPad2,6", "iPad2,7":            return "iPadMini"
            case "iPad4,4", "iPad4,5", "iPad4,6":            return "iPadMini2"
            case "iPad4,7", "iPad4,8", "iPad4,9":            return "iPadMini3"
            case "iPad5,1", "iPad5,2":                       return "iPadMini4"
            case "iPad6,3", "iPad6,4", "iPad6,7", "iPad6,8": return "iPadPro"
                
            /*** iPod ***/
            case "iPod1,1":                                  return "iPodTouch1Gen"
            case "iPod2,1":                                  return "iPodTouch2Gen"
            case "iPod3,1":                                  return "iPodTouch3Gen"
            case "iPod4,1":                                  return "iPodTouch4Gen"
            case "iPod5,1":                                  return "iPodTouch5Gen"
            case "iPod7,1":                                  return "iPodTouch6Gen"
                
            /*** Simulator ***/
            case "i386", "x86_64":                           return "Simulator"
                
            default:                                         return "Unknown"
            }
        }
    }
    /// get the screen width (x)
    public static var screenWidth: CGFloat {
        get {
            return UIScreen.main.bounds.size.width
        }
    }
    /// get the screen height (y)
    public static var screenHeight: CGFloat {
        get {
            return UIScreen.main.bounds.size.height
        }
    }
    /// get the brightness of screen
    public static var screenBrightness: CGFloat {
        get {
            return UIScreen.main.brightness
        }
    }
    
    public static var isMultitaskingSupported: Bool {
        get {
            return UIDevice.current.isMultitaskingSupported
        }
    }
    /// is the debugger attached
    public static var isDebuggerAttached: Bool {
        get {
            var info = kinfo_proc()
            var mib : [Int32] = [CTL_KERN, KERN_PROC, KERN_PROC_PID, getpid()]
            var size = MemoryLayout.stride(ofValue: info)
            let junk = sysctl(&mib, UInt32(mib.count), &info, &size, nil, 0)
            assert(junk == 0, "sysctl failed")
            return (info.kp_proc.p_flag & P_TRACED) != 0
        }
    }
    
    /// is the device plugged in
    public static var isPluggedIn: Bool {
        get {
            let preEnable = UIDevice.current.isBatteryMonitoringEnabled
            UIDevice.current.isBatteryMonitoringEnabled = true
            let batteryState = UIDevice.current.batteryState
            UIDevice.current.isBatteryMonitoringEnabled = preEnable
            return (batteryState == .charging || batteryState == .full)
        }
    }
    
    /// is the device jailbrokened
    public static var isJailbroken: Bool {
        let cydiaURL = "/Applications/Cydia.app"
        return FileManager.default.fileExists(atPath: cydiaURL)
    }
    
}
