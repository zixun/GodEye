//
//  LeakRecordModel.swift
//  Pods
//
//  Created by zixun on 17/1/12.
//
//

import Foundation

final class LeakRecordModel: NSObject {
    
    private(set) var clazz: String!
    
    private(set) var address: String!
    
    init(obj:NSObject) {
        self.clazz = NSStringFromClass(obj.classForCoder)
        self.address = String(format:"%p", obj)
    }
    
    init(clazz:String, address: String) {
        super.init()
        self.clazz = clazz
        self.address = address
    }
}
