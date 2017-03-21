//
//  LogModel.swift
//  Pods
//
//  Created by zixun on 17/1/10.
//
//

import Foundation

public enum Log4gType: Int {
    case log = 1
    case warning = 2
    case error = 3
}

open class LogModel: NSObject {
    
    open private(set) var type: Log4gType!
    
    /// date for Time stamp
    open private(set) var date: Date!
    
    /// thread which log the message
    open private(set) var thread: Thread!
    
    /// filename with extension
    open private(set) var file: String!
    
    /// number of line in source code file
    open private(set) var line: Int!
    
    /// name of the function which log the message
    open private(set) var function: String!
    
    /// message be logged
    open private(set) var message: String!
    
    init(type:Log4gType,
         thread:Thread,
         message: String,
         file: String,
         line: Int,
         function: String) {
        super.init()
        self.date = Date()
        self.type = type
        self.thread = thread
        self.file = file
        self.line = line
        self.function = function
        self.message = message
    }
}
