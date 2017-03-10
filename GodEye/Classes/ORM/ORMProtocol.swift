//
//  RecordORMProtocol.swift
//  Pods
//
//  Created by zixun on 16/12/30.
//
//

import Foundation
import SQLite
import AppBaseKit

/// ORM protocol, variable and function which need implement
protocol RecordORMProtocol: class {
    
    /// type of record, need implement the get func
    static var type:RecordType { get }
    
    /// mapping model to ORM's relation
    ///
    /// - Returns: relation: SQLite's Setter
    func mappingToRelation() -> [Setter]
    
    /// mapping relation to model
    ///
    /// - Parameter row: relation: SQLite's Row
    /// - Returns: model
    static func mappingToObject(with row:Row) -> Self
    
    /// configure the tableBuilder while create the table
    ///
    /// - Parameter tableBuilder: TableBuilder
    static func configure(tableBuilder:TableBuilder)
    
    /// configure select conditions in table
    ///
    /// - Parameter table: Table
    /// - Returns: Table
    static func configure(select table:Table) -> Table
    
    
    /// NSAttributedString of model
    ///
    /// - Returns: NSAttributedString
    func attributeString() -> NSAttributedString
    
}

private var kShowAll = "\(#file)+\(#line)"
private var kAddCount = "\(#file)+\(#line)"


// MARK: - Don't need to implement，just get and set immediately
extension RecordORMProtocol {
    
    internal var showAll: Bool {
        get {
            return objc_getAssociatedObject(self, &kShowAll) as? Bool ?? true
        }
        set {
            objc_setAssociatedObject(self, &kShowAll, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    internal static var addCount: Int {
        get {
            return objc_getAssociatedObject(self, &kAddCount) as? Int ?? 0
        }
        set {
            objc_setAssociatedObject(self, &kAddCount, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}


// MARK: - function that can call immediately
extension RecordORMProtocol {
    
    static func create() {
        do {
            let sql = self.table.create(temporary: false, ifNotExists: true, block: {(t:TableBuilder) in
                t.column(self.col_id, primaryKey: true)
                self.configure(tableBuilder: t)
            })
            try self.connection?.run(sql)
        } catch {
            fatalError("create log table failure")
        }
    }
    
    func insert(complete:@escaping (_ success:Bool)->()) {
        
        
        let insert = Self.table.insert(self.mappingToRelation())
        
        Self.queue.async {
            do {
                let rowid = try Self.connection?.run(insert)
            }catch {
                DispatchQueue.main.async {
                    complete(false)
                }
            }
            DispatchQueue.main.async {
                complete(true)
            }
        }
    }
    
    func insertSync(complete:@escaping (_ success:Bool)->()){
        let insert = Self.table.insert(self.mappingToRelation())
        
        do {
            let rowid = try Self.connection?.run(insert)
        }catch {
            complete(false)
        }
        complete(true)
    }
    
    static func select(at index:Int) -> [Self]? {
        let pagesize = 100
        let offset = pagesize * index + Self.addCount

        var select = self.configure(select: self.table.select(Self.col_id))
            .order(Self.col_id.desc)
            .limit(pagesize, offset: offset)
        
        do {
            if let sequence = try Self.connection?.prepare(select) {
                var result = [Self]()
                for row in sequence {
                   result.append(Self.mappingToObject(with: row))
                }
                return result.reversed()
            }
            return nil
        } catch {
            return nil
        }
    }
    
    
    static func delete(complete:@escaping (_ success:Bool)->())  {
        Self.queue.async {
            let delete = self.table.delete()
            
            do {
                let rowid = try Self.connection?.run(delete)
                self.addCount = 0
            }catch {
                DispatchQueue.main.async {
                    complete(false)
                }
            }
            
            DispatchQueue.main.async {
                complete(true)
            }
        }
    }
}

// MARK: - Inner used variable
extension RecordORMProtocol {
    fileprivate static var table: Table {
        get {
            var key = "\(#file)+\(#line)"
            guard let result = objc_getAssociatedObject(self, &key) as? Table else {
                let result = Table(self.type.tableName())
                objc_setAssociatedObject(self, &key, result, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return result
            }
            return result
        }
    }
    
    fileprivate static var connection:Connection? {
        get {
            var key = "\(#file)+\(#line)"
            let path = AppPathForDocumentsResource(relativePath: "/GodEye.sqlite")
            do {
                guard let result = objc_getAssociatedObject(self, &key) as? Connection else {
                    let result = try Connection(path)
                    objc_setAssociatedObject(self, &key, result, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                    return result
                }
                
                return result
            } catch {
                fatalError("Init GodEye database failue")
                return nil
            }
        }
    }
    
    fileprivate static var queue: DispatchQueue {
        get {
            var key = "\(#file)+\(#line)"
            guard let result = objc_getAssociatedObject(self, &key) as? DispatchQueue else {
                let result = DispatchQueue(label: "RecordDB")
                objc_setAssociatedObject(self, &key, result, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return result
            }
            return result
        }
    }
    
    fileprivate static var col_id:Expression<Int64> {
        get {
            var key = "\(#file)+\(#line)"
            guard let result = objc_getAssociatedObject(self, &key) as? Expression<Int64> else {
                let result = Expression<Int64>("id")
                objc_setAssociatedObject(self, &key, result, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return result
            }
            return result
        }
    }
}
