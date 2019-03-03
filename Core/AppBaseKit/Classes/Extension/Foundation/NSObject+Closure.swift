//
//  NSObject+Closure.swift
//  Pods
//
//  Created by zixun on 2016/10/22.
//
//

import Foundation

public extension NSObject {
    
    func perform(closure:@escaping ()->(), afterDelay:TimeInterval) -> Void {
        
        var canceled = false
        
        func wrappingClosure(cancel:Bool)->Void {
            if cancel {
                canceled = true
                return
            }
            
            if canceled == false {
                closure()
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + afterDelay) { 
            wrappingClosure(cancel: false)
        }
        
    }
    
}
