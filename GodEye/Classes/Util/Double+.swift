//
//  Double+.swift
//  Pods
//
//  Created by zixun on 17/1/14.
//
//

import Foundation

extension Double {
    func storageCapacity() -> (capacity:Double,unit:String) {
        
        let radix = 1000.0
        
        guard self > radix else {
            return (self,"B")
        }
        
        guard self > radix * radix else {
            return (self / radix,"KB")
        }
        
        guard self > radix * radix * radix else {
            return (self / (radix * radix),"MB")
        }
        
        return (self / (radix * radix * radix),"GB")
    }
}
