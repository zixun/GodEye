//
//  MonitorSystemType.swift
//  Pods
//
//  Created by zixun on 17/1/13.
//
//

import Foundation

enum MonitorSystemType {
    case appCPU
    case appRAM
    case appFPS
    case appNET
    
    case sysCPU
    case sysRAM
    case sysNET
}

extension MonitorSystemType {
    
    var info: String {
        switch self {
        case .appCPU:
            return "APP CPU:"
        case .appRAM:
            return "APP RAM:"
        case .appFPS:
            return "APP FPS:"
        case .appNET:
            return "APP NET FLOW:"
        case .sysCPU:
            return "SYS CPU:"
        case .sysRAM:
            return "SYS RAM:"
        case .sysNET:
            return "SYS NET FLOW:"
        }
    }
    
    var initialValue: String {
        switch self {
        case .appCPU:
            return "0%"
        case .appRAM:
            return "0B"
        case .appFPS:
            return "0FPS"
        case .appNET:
            return "0B"
        case .sysCPU:
            return "0%"
        case .sysRAM:
            return "0B"
        case .sysNET:
            return "Undefine"
        }
    }
    
    var hasDetail: Bool {
        switch self {
        case .appCPU:
            return true
        case .appRAM:
            return true
        case .appFPS:
            return true
        case .appNET:
            return false
        case .sysCPU:
            return true
        case .sysRAM:
            return true
        case .sysNET:
            return false
        }
    }
    
    
    var axisMaximum:Double {
        switch self {
        case .appCPU:
            return 100.0
        case .appRAM:
            return 500.0
        case .appFPS:
            return 100.0
        case .appNET:
            return 500.0
        case .sysCPU:
            return 100.0
        case .sysRAM:
            return 100.0
        case .sysNET:
            return 0
        }
    }
    
    var limitLineValue: Double? {
        switch self {
        case .appFPS:
            return self.axisMaximum * 0.3
        case .sysRAM:
            return nil
        default:
            return self.axisMaximum * 0.9
        }
    }
}
