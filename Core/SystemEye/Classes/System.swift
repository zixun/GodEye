//
//  System.swift
//  Pods
//
//  Created by zixun on 17/1/19.
//
//

import Foundation
private let HOST_BASIC_INFO_COUNT         : mach_msg_type_number_t =
    UInt32(MemoryLayout<host_basic_info_data_t>.size / MemoryLayout<integer_t>.size)

open class System: NSObject {
    
    //--------------------------------------------------------------------------
    // MARK: - OPEN PROPERTY
    //--------------------------------------------------------------------------
    
    public static let hardware = Hardware.classForCoder() as! Hardware.Type
    
    public static let cpu      = CPU.classForCoder() as! CPU.Type
    
    public static let memory   = Memory.classForCoder() as! Memory.Type
    
    public static let network  = Network.classForCoder() as! Network.Type
    
    //--------------------------------------------------------------------------
    // MARK: - Internal PROPERTY
    //--------------------------------------------------------------------------
    static var hostBasicInfo: host_basic_info {
        get {
            var size     = HOST_BASIC_INFO_COUNT
            var hostInfo = host_basic_info()
            
            let result = withUnsafeMutablePointer(to: &hostInfo) {
                $0.withMemoryRebound(to: integer_t.self, capacity: Int(size), {
                    host_info(machHost, HOST_BASIC_INFO,$0,&size)
                })
            }
            #if DEBUG
                if result != KERN_SUCCESS {
                    fatalError("ERROR - \(#file):\(#function) - kern_result_t = "
                        + "\(result)")
                }
            #endif
            return hostInfo
        }
    }
    
    //--------------------------------------------------------------------------
    // MARK: - PRIVATE PROPERTY
    //--------------------------------------------------------------------------
    static let machHost = mach_host_self()
}
