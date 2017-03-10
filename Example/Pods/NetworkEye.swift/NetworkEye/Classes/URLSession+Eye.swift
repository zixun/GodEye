//
//  URLSession+Eye.swift
//  Pods
//
//  Created by zixun on 16/12/26.
//
//

import Foundation
import AppSwizzle

extension URLSession {
    convenience init(configurationMonitor: URLSessionConfiguration, delegate: URLSessionDelegate?, delegateQueue queue: OperationQueue?) {
        
        if configurationMonitor.protocolClasses != nil {
            configurationMonitor.protocolClasses!.insert(EyeProtocol.classForCoder(), at: 0)
        }else {
            configurationMonitor.protocolClasses = [EyeProtocol.classForCoder()]
        }
        
        self.init(configurationMonitor: configurationMonitor, delegate: delegate, delegateQueue: queue)
    }
    
    class func open() {
        if self.isSwizzled == false && self.hook() == .Succeed {
            self.isSwizzled = true
        }else {
            print("[NetworkEye] already started or hook failure")
        }
    }
    
    class func close() {
        if self.isSwizzled == true && self.hook() == .Succeed {
            self.isSwizzled = false
        }else {
            print("[NetworkEye] already stoped or hook failure")
        }
    }
    
    
    private class func hook() -> SwizzleResult {
        // let orig = #selector(URLSession.init(configuration:delegate:delegateQueue:))
        // the result is sessionWithConfiguration:delegate:delegateQueue: which runtime can't find it
        
        let orig = Selector("initWithConfiguration:delegate:delegateQueue:")
        let alter = #selector(URLSession.init(configurationMonitor:delegate:delegateQueue:))
        let result = URLSession.swizzleInstanceMethod(origSelector: orig, toAlterSelector: alter)
        return result
    }
    
    
    
    private static var isSwizzled:Bool {
        set{
            objc_setAssociatedObject(self, &key.isSwizzled, isSwizzled, .OBJC_ASSOCIATION_ASSIGN);
        }
        get{
            let result = objc_getAssociatedObject(self, &key.isSwizzled) as? Bool
            if result == nil {
                return false
            }
            return result!
        }
    }
    
    private struct key {
        static var isSwizzled: Character = "c"
    }
}
