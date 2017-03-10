//
//  CommandModel.swift
//  Pods
//
//  Created by zixun on 17/1/7.
//
//

import Foundation

final class CommandRecordModel: NSObject {
    private(set) var command: String!
    private(set) var actionResult: String!
    
    init(command:String,actionResult:String) {
        super.init()
        self.command = command
        self.actionResult = actionResult
    }
}
