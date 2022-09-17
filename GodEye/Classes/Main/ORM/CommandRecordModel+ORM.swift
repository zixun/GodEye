//
//  CommandRecordModel+ORM.swift
//  Pods
//
//  Created by zixun on 17/1/9.
//
//

import Foundation
import SQLite

extension CommandRecordModel: RecordORMProtocol {
    
    static var type: RecordType {
        return RecordType.command
    }
    
    func mappingToRelation() -> [Setter] {
        return [CommandRecordModel.col.command <- self.command,
                CommandRecordModel.col.actionResult <- self.actionResult]
    }
    
    static func mappingToObject(with row: Row) -> CommandRecordModel {
        return CommandRecordModel(command: row[CommandRecordModel.col.command],
                                  actionResult: row[CommandRecordModel.col.actionResult])
    }
    
    static func configure(tableBuilder: TableBuilder) {
        tableBuilder.column(CommandRecordModel.col.command)
        tableBuilder.column(CommandRecordModel.col.actionResult)
    }
    
    static func configure(select table:Table) -> Table {
        return table.select(CommandRecordModel.col.command,
                            CommandRecordModel.col.actionResult)
    }
    
    func attributeString() -> NSAttributedString {
        return CommandRecordViewModel(self).attributeString()
    }
    
    class col: NSObject {
        static let command = Expression<String>("command")
        static let actionResult = Expression<String>("actionResult")
    }
}
