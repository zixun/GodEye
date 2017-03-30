//
//  GodDB.swift
//  GodEye
//
//  Created by zixun on 2017/3/30.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import Foundation
import AppBaseKit

class GodDB: NSObject {
    
    static let sharedDB = GodDB()
    
    func openDB(name:String) {
        // get the documentPath
        
        let path = AppPathForDocumentsResource(relativePath: "/GodEye.db")
        
        print(path)
    }
    
    //--------------------------------------------------------------------------
    // MARK: - PRIVATE VARIBLE
    //--------------------------------------------------------------------------
    private let DB_NAME = "GodEye.db"
}
