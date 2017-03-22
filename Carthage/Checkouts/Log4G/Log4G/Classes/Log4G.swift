//
//  Log4G.swift
//  Pods
//
//  Created by zixun on 17/1/10.
//
//

import Foundation

//--------------------------------------------------------------------------
// MARK: - Log4gDelegate
//--------------------------------------------------------------------------
public protocol Log4GDelegate: NSObjectProtocol {
    func log4gDidRecord(with model:LogModel)
}

//--------------------------------------------------------------------------
// MARK: - WeakLog4gDelegate
// DESCRIPTION: Weak wrap of delegate
//--------------------------------------------------------------------------
class WeakLog4GDelegate: NSObject {
    weak var delegate : Log4GDelegate?
    init (delegate: Log4GDelegate) {
        super.init()
        self.delegate = delegate
    }
}

//--------------------------------------------------------------------------
// MARK: - Log4G
// DESCRIPTION: Simple, lightweight logging framework written in Swift
//              4G means for GodEye, it was development for GodEye at the beginning of the time
//--------------------------------------------------------------------------
open class Log4G: NSObject {
    
    //--------------------------------------------------------------------------
    // MARK: OPEN FUNCTION
    //--------------------------------------------------------------------------
    
    /// record a log type message
    ///
    /// - Parameters:
    ///   - message: log message
    ///   - file: file which call the api
    ///   - line: line number at file which call the api
    ///   - function: function name which call the api
    open class func log(_ message: Any = "",
                        file: String = #file,
                        line: Int = #line,
                        function: String = #function) {
        self.shared.record(type: .log,
                           thread: Thread.current,
                           message: "\(message)",
                           file: file,
                           line: line,
                           function: function)
    }
    
    /// record a warning type message
    ///
    /// - Parameters:
    ///   - message: warning message
    ///   - file: file which call the api
    ///   - line: line number at file which call the api
    ///   - function: function name which call the api
    open class func warning(_ message: Any = "",
                            file: String = #file,
                            line: Int = #line,
                            function: String = #function) {
        self.shared.record(type: .warning,
                           thread: Thread.current,
                           message: "\(message)",
                           file: file,
                           line: line,
                           function: function)
    }
    
    /// record an error type message
    ///
    /// - Parameters:
    ///   - message: error message
    ///   - file: file which call the api
    ///   - line: line number at file which call the api
    ///   - function: function name which call the api
    open class func error(_ message: Any = "",
                          file: String = #file,
                          line: Int = #line,
                          function: String = #function) {
        self.shared.record(type: .error,
                           thread: Thread.current,
                           message: "\(message)",
                           file: file,
                           line: line,
                           function: function)
    }
    
    //--------------------------------------------------------------------------
    // MARK: PRIVATE FUNCTION
    //--------------------------------------------------------------------------
    
    /// record message base function
    ///
    /// - Parameters:
    ///   - type: log type
    ///   - thread: thread which log the messsage
    ///   - message: log message
    ///   - file: file which call the api
    ///   - line: line number at file which call the api
    ///   - function: function name which call the api
    private func record(type:Log4gType,
                     thread:Thread,
                     message: String,
                     file: String,
                     line: Int,
                     function: String) {
        self.queue.async {
            let model = LogModel(type: type,
                                 thread: thread,
                                 message: message,
                                 file: self.name(of: file),
                                 line: line,
                                 function: function)
            print(message)
            
            for delegate in self.delegates {
                delegate.delegate?.log4gDidRecord(with: model)
            }
            
        }
    }
    
    /// get the name of file in filepath
    ///
    /// - Parameter file: path of file
    /// - Returns: filename
    private func name(of file:String) -> String {
        return URL(fileURLWithPath: file).lastPathComponent
    }
    
    
    //MARK: - Private Variable
    
    /// singleton for Log4g
    fileprivate static let shared = Log4G()
    /// log queue
    private let queue = DispatchQueue(label: "Log4g")
    /// weak delegates
    fileprivate var delegates = [WeakLog4GDelegate]()
    
}

//--------------------------------------------------------------------------
// MARK: - Log4gDelegate Fucntion Extension
//--------------------------------------------------------------------------
extension Log4G {
    
    open class var delegateCount: Int {
        get {
            return self.shared.delegates.count
        }
    }
    
    open class func add(delegate:Log4GDelegate) {
        let log4g = self.shared
        
        // delete null week delegate
        log4g.delegates = log4g.delegates.filter {
            return $0.delegate != nil
        }
        
        // judge if contains the delegate from parameter
        let contains = log4g.delegates.contains {
            return $0.delegate?.hash == delegate.hash
        }
        // if not contains, append it with weak wrapped
        if contains == false {
            let week = WeakLog4GDelegate(delegate: delegate)
            
            self.shared.delegates.append(week)
        }
    }
    
    open class func remove(delegate:Log4GDelegate) {
        let log4g = self.shared
        
        log4g.delegates = log4g.delegates.filter {
            // filter null weak delegate
            return $0.delegate != nil
        }.filter {
            // filter the delegate from parameter
            return $0.delegate?.hash != delegate.hash
        }
    }
}


