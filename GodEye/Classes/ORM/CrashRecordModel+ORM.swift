//
//  CrashRecordModel+ORM.swift
//  Pods
//
//  Created by zixun on 17/1/9.
//
//

import Foundation
import SQLite
import CrashEye

extension CrashRecordModel: RecordORMProtocol {
    
    static var type: RecordType {
        return RecordType.crash
    }
    
    func mappingToRelation() -> [Setter] {
        return [CrashRecordModel.col.type <- self.type.rawValue,
                CrashRecordModel.col.name <- self.name,
                CrashRecordModel.col.reason <- self.reason,
                CrashRecordModel.col.appinfo <- self.appinfo,
                CrashRecordModel.col.callStack <- self.callStack]
    }
    
    static func mappingToObject(with row: Row) -> CrashRecordModel {
        let type = CrashModelType(rawValue:row[CrashRecordModel.col.type])!
        let name = row[CrashRecordModel.col.name]
        let reason = row[CrashRecordModel.col.reason]
        let appinfo = row[CrashRecordModel.col.appinfo]
        let callStack = row[CrashRecordModel.col.callStack]
        return CrashRecordModel(type: type, name: name, reason: reason, appinfo: appinfo, callStack: callStack)
    }
    
    static func configure(tableBuilder:TableBuilder) {
        tableBuilder.column(CrashRecordModel.col.type)
        tableBuilder.column(CrashRecordModel.col.name)
        tableBuilder.column(CrashRecordModel.col.reason)
        tableBuilder.column(CrashRecordModel.col.appinfo)
        tableBuilder.column(CrashRecordModel.col.callStack)
    }
    
    static func configure(select table:Table) -> Table {
        return table.select(CrashRecordModel.col.type,
                            CrashRecordModel.col.name,
                            CrashRecordModel.col.reason,
                            CrashRecordModel.col.appinfo,
                            CrashRecordModel.col.callStack)
    }
    
    func attributeString() -> NSAttributedString {
        return CrashRecordViewModel(self).attributeString()
    }
    
    class col: NSObject {
        static let type = Expression<Int>("type")
        static let name = Expression<String>("name")
        static let reason = Expression<String>("reason")
        static let appinfo = Expression<String>("appinfo")
        static let callStack = Expression<String>("callStack")
    }
}
