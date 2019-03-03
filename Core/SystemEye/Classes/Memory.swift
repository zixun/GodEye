//
//  Memory.swift
//  Pods
//
//  Created by zixun on 2016/12/6.
//
//

import Foundation

private let HOST_VM_INFO64_COUNT: mach_msg_type_number_t =
    UInt32(MemoryLayout<vm_statistics64_data_t>.size / MemoryLayout<integer_t>.size)

private let PAGE_SIZE : Double = Double(vm_kernel_page_size)

open class Memory: NSObject {
    
    //--------------------------------------------------------------------------
    // MARK: OPEN FUNCTION
    //--------------------------------------------------------------------------
    
    /// Memory usage of application
    open class func applicationUsage() -> (used: Double,
                                          total: Double) {
        var info = mach_task_basic_info()
        var count = mach_msg_type_number_t(MemoryLayout.size(ofValue: info) / MemoryLayout<integer_t>.size)
        let kerr = withUnsafeMutablePointer(to: &info) {
            return $0.withMemoryRebound(to: integer_t.self, capacity: Int(count)) {
                return task_info(mach_task_self_,task_flavor_t(MACH_TASK_BASIC_INFO),$0,&count
                )
            }
        }
        guard kerr == KERN_SUCCESS else {
            return (0,self.totalBytes)
        }
        
        return (Double(info.resident_size),self.totalBytes)
    }
    
    /// Memory usage of system
    open class func systemUsage() -> (free: Double,
                                    active: Double,
                                  inactive: Double,
                                     wired: Double,
                                compressed: Double,
                                     total: Double) {
        let statistics = self.VMStatistics64()
        
        
        let free = Double(statistics.free_count) * PAGE_SIZE
        let active = Double(statistics.active_count) * PAGE_SIZE
        let inactive = Double(statistics.inactive_count) * PAGE_SIZE
        let wired = Double(statistics.wire_count) * PAGE_SIZE
        let compressed = Double(statistics.compressor_page_count) * PAGE_SIZE
        
        return (free,active,inactive,wired,compressed,self.totalBytes)
    }
    
    //--------------------------------------------------------------------------
    // MARK: PRIVATE PROPERTY
    //--------------------------------------------------------------------------
    private static let totalBytes = Double(ProcessInfo.processInfo.physicalMemory)
    
    //--------------------------------------------------------------------------
    // MARK: PRIVATE FUNCTION
    //--------------------------------------------------------------------------
    private static func VMStatistics64() -> vm_statistics64 {
        var size     = HOST_VM_INFO64_COUNT
        var hostInfo = vm_statistics64()
        
        let result = withUnsafeMutablePointer(to: &hostInfo) {
            $0.withMemoryRebound(to: integer_t.self, capacity: Int(size)) {
                host_statistics64(System.machHost, HOST_VM_INFO64, $0, &size)
            }
        }
        #if DEBUG
            if result != KERN_SUCCESS {
                print("ERROR - \(#file):\(#function) - kern_result_t = "
                    + "\(result)")
            }
        #endif
        return hostInfo
    }
}
