//
//  CrashRecordModel.swift
//  Pods
//
//  Created by zixun on 16/12/28.
//
//

import Foundation
import SQLite

final class CrashRecordModel: NSObject {
    
    public var type: CrashModelType!
    public var name: String!
    public var reason: String!
    public var appinfo: String!
    public var callStack: String!
    
    init(model:CrashModel) {
        super.init()
        self.type = model.type
        self.name = model.name
        self.reason = model.reason
        self.appinfo = model.appinfo
        self.callStack = model.callStack
    }
    
    init(type:CrashModelType, name:String, reason:String, appinfo:String,callStack:String) {
        super.init()
        self.type = type
        self.name = name
        self.reason = reason
        self.appinfo = appinfo
        self.callStack = callStack
    }
}
