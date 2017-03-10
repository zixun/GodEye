//
//  ANRRecordModel+ORM.swift
//  Pods
//
//  Created by zixun on 17/1/9.
//
//

import Foundation
import SQLite

extension ANRRecordModel: RecordORMProtocol {
    
    static var type:RecordType {
        return RecordType.anr
    }
    
    func mappingToRelation() -> [Setter] {
        return [ANRRecordModel.col.threshold <- self.threshold,
                ANRRecordModel.col.mainThreadBacktrace <- self.mainThreadBacktrace,
                ANRRecordModel.col.allThreadBacktrace <- self.allThreadBacktrace]
    }
    
    static func mappingToObject(with row: Row) -> ANRRecordModel {
        return ANRRecordModel(threshold: row[ANRRecordModel.col.threshold],
                              mainThreadBacktrace: row[ANRRecordModel.col.mainThreadBacktrace],
                              allThreadBacktrace: row[ANRRecordModel.col.allThreadBacktrace])
    }
    
    static func configure(tableBuilder:TableBuilder) {
        tableBuilder.column(ANRRecordModel.col.threshold)
        tableBuilder.column(ANRRecordModel.col.mainThreadBacktrace)
        tableBuilder.column(ANRRecordModel.col.allThreadBacktrace)
    }
    
    static func configure(select table:Table) -> Table {
        return table.select(ANRRecordModel.col.threshold,
                            ANRRecordModel.col.mainThreadBacktrace,
                            ANRRecordModel.col.allThreadBacktrace)
    }
    
    
    
    static func prepare(sequence: AnySequence<Row>) -> [ANRRecordModel] {
        return sequence.map { (row:Row) -> ANRRecordModel in
            return ANRRecordModel(threshold: row[ANRRecordModel.col.threshold],
                                  mainThreadBacktrace: row[ANRRecordModel.col.mainThreadBacktrace],
                                  allThreadBacktrace: row[ANRRecordModel.col.allThreadBacktrace])
        }
    }
    
    func attributeString() -> NSAttributedString {
        return ANRRecordViewModel(self).attributeString()
    }
    
    class col: NSObject {
        static let threshold = Expression<Double>("threshold")
        static let mainThreadBacktrace = Expression<String?>("mainThreadBacktrace")
        static let allThreadBacktrace = Expression<String?>("allThreadBacktrace")
    }
}


