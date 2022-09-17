//
//  Configuration.swift
//  Pods
//
//  Created by zixun on 16/12/27.
//
//

import Foundation

//--------------------------------------------------------------------------
// MARK: - Configuration
// DESCRIPTION: Configuration form use setting or default
//--------------------------------------------------------------------------
open class Configuration: NSObject {
    /// control configuration
    open private(set) var control = ControlConfiguration()
    /// command configuration
    open private(set) var command = CommandConfiguration()
    /// default switch configuration
    open private(set) var defaultSwitch = SwitchConfiguration()
}
