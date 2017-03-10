//
//  ControlConfiguration.swift
//  Pods
//
//  Created by zixun on 17/1/22.
//
//

import Foundation

//--------------------------------------------------------------------------
// MARK: - ControlConfiguration
// DESCRIPTION: control configuration for GodEye
//--------------------------------------------------------------------------
open class ControlConfiguration: NSObject {
    
    //--------------------------------------------------------------------------
    // MARK: OPEN PROPERTY
    //--------------------------------------------------------------------------
    
    /// is console Enabled, default is true
    open var enabled = true
    
    /// number of touches to show the console under the simulator, default is 2
    open var touchesShowForSimulator = 2
    
    /// number of touches to show the console under the device, default is 3
    open var touchesShowForDevice = 3
    
    /// allowed shake to show under the simulator, default is true
    open var shakeShowForSimulator = true
    
    /// allowed share to show under the device, default is false
    open var shakeShowForDevice = false
    
    //--------------------------------------------------------------------------
    // MARK: INTERNAL FUNCTION
    //--------------------------------------------------------------------------
    
    /// touches to show on current environment
    ///
    /// - Returns: touches
    func touchesToShow() -> Int {
        #if (arch(i386) || arch(x86_64)) && os(iOS)
            return self.touchesShowForSimulator
        #else
            return self.touchesShowForDevice
        #endif
    }
    
    
    /// shake to show on current evvironment
    ///
    /// - Returns: can shake to show
    func shakeToShow() -> Bool {
        #if (arch(i386) || arch(x86_64)) && os(iOS)
            return self.shakeShowForSimulator
        #else
            return self.shakeShowForDevice
        #endif
    }
}
