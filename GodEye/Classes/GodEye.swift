//
//  GodEye.swift
//  Pods
//
//  Created by zixun on 16/12/27.
//
//

import Foundation

open class GodEye: NSObject {
    
    open class func makeEye(with window:UIWindow, configuration: Configuration = Configuration()) {
        LogRecordModel.create()
        CrashRecordModel.create()
        NetworkRecordModel.create()
        ANRRecordModel.create()
        CommandRecordModel.create()
        LeakRecordModel.create()
        
        window.makeEye(with: configuration)
    }
}
