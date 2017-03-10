//
//  LogRecordModel.swift
//  Pods
//
//  Created by zixun on 16/12/28.
//
//

import Foundation
import Log4G

enum LogRecordModelType:Int {
    case asl = 1
    case log = 2
    case warning = 3
    case error = 4
    
    func string() -> String {
        switch self {
        case .asl:
            return "ASL"
        case .log:
            return "LOG"
        case .warning:
            return "WARNING"
        case .error:
            return "ERROR"
        }
    }
    
    func color() -> UIColor {
        switch self {
        case .asl:
            return UIColor(hex: 0x94C76F)
        case .log:
            return UIColor(hex: 0x94C76F)
        case .warning:
            return UIColor(hex: 0xFEC42E)
        case .error:
            return UIColor(hex: 0xDF1921)
        }
    }
}

final class LogRecordModel: NSObject {
    private(set) var type: LogRecordModelType!
    /// date for Time stamp
    private(set) var date: String?
    
    /// thread which log the message
    private(set) var thread: String?
    
    /// filename with extension
    private(set) var file: String?
    
    /// number of line in source code file
    private(set) var line: Int?
    
    /// name of the function which log the message
    private(set) var function: String?
    
    /// message be logged
    private(set) var message: String!
    
    init(model:LogModel) {
        super.init()
        self.type = self.type(of: model.type)
        self.date = model.date.string(with: "yyyy-MM-dd HH:mm:ss")
        self.thread = model.thread.threadName
        self.file = model.file
        self.line = model.line
        self.function = model.function
        self.message = model.message
    }
    
    init(type:LogRecordModelType,
         message:String,
         date:String? = nil,
         thread:String? = nil,
         file: String? = nil,
         line: Int? = nil,
         function: String? = nil) {
        super.init()
        self.type = type
        self.message = message
        self.date = date
        self.thread = thread
        self.file = file
        self.line = line
        self.function = function
    }
    
    private func type(of log4gType:Log4gType) -> LogRecordModelType {
        switch log4gType {
        case .log:
            return LogRecordModelType.log
        case .warning:
            return LogRecordModelType.warning
        case .error:
            return LogRecordModelType.error
        }
    }
}
