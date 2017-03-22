//
//  AppBacktrace.swift
//  Pods
//
//  Created by zixun on 16/12/19.
//
//

import Foundation

class AppBacktrace: NSObject {
    
    
    class func with(thread: Thread) -> String {
        let machThread = self.bs_machThread(from: thread)
        return BSBacktraceLogger.backtrace(ofMachthread: machThread)
    }
    
    class func currentThread() -> String {
        return self.with(thread: Thread.current)
    }
    
    class func mainThread() -> String {
        return self.with(thread: Thread.main)
    }
    
    class func allThread() -> String {
        
        var threads: thread_act_array_t? = nil
        var thread_count = mach_msg_type_number_t()
        
        if task_threads(mach_task_self_, &(threads), &thread_count) != KERN_SUCCESS {
            return ""
        }
        
        var resultString = "Call Backtrace of \(thread_count) threads:\n"
        
        for i in 0..<thread_count {
            let index = Int(i)
            let bt = BSBacktraceLogger.backtrace(ofMachthread: threads![index])
            resultString.append(bt!)
        }
        
        return resultString
    }
    
    
    
    static var main_thread_id: mach_port_t!
    
    
    private class func bs_machThread(from nsthread:Thread) -> thread_t {
        
        var name:[Int8] = Array(repeating:0, count:256)
        
        var list: thread_act_array_t? = nil
        var count = mach_msg_type_number_t()
        
        if task_threads(mach_task_self_, &(list), &count) != KERN_SUCCESS {
            return mach_thread_self()
        }
        
        let currentTimestamp = NSDate().timeIntervalSince1970
        let originName = nsthread.name
        nsthread.name = "\(currentTimestamp)"
        
        if nsthread.isMainThread {
            return self.main_thread_id
        }
        
        for i in 0..<count {
            
            let index = Int(i)
            let pt = pthread_from_mach_thread_np(list![index])
            if nsthread.isMainThread {
                
                if list![index] == self.main_thread_id  {
                    return list![index]
                }
            }
            
            if (pt != nil) {
                pthread_getname_np(pt!, &name, name.count)
                
                print(nsthread.name)
                
                print(String(utf8String: name))
                
                if String(utf8String: name) == nsthread.name {
                    nsthread.name = originName
                    return list![index]
                }
            }
            
            
        }
        nsthread.name = originName
        return mach_thread_self()
    }
}
