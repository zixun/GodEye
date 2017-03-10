//
//  ANRModel.swift
//  Pods
//
//  Created by zixun on 16/12/30.
//
//

import Foundation
import SQLite



final class ANRRecordModel: NSObject {
    
    private(set) var threshold: Double!
    private(set) var mainThreadBacktrace:String?
    private(set) var allThreadBacktrace:String?
    
    init(threshold:Double,mainThreadBacktrace:String?,allThreadBacktrace:String?) {
        super.init()
        self.threshold = threshold
        self.mainThreadBacktrace = mainThreadBacktrace
        self.allThreadBacktrace = allThreadBacktrace
        self.showAll = false
    }
}
