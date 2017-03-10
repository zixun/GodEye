//
//  Variable.swift
//  Pods
//
//  Created by zixun on 16/12/12.
//
//

import Foundation

//--------------------------------------------------------------------------
// MARK: - Variable
// DESCRIPTION: light wrap of the property of runtime
//--------------------------------------------------------------------------
class Variable: NSObject {
    
    init(property:objc_property_t) {
        super.init()
        self.property = property
    }
    
    //--------------------------------------------------------------------------
    // MARK: INTERNAL FUNCTION
    //--------------------------------------------------------------------------
    
    /// is a strong property
    func isStrong() -> Bool {
        let attr = String(cString: property_getAttributes(self.property))
        return attr.contains("&")
    }
    
    /// name of the property
    func name() -> String {
        return String(cString: property_getName(self.property))
    }
    
    /// type of the property
    func type() -> AnyClass? {
        let t = String(cString: property_getAttributes(self.property)).components(separatedBy: ",").first
        guard let type = t?.between(left: "@\"", "\"") else {
            return nil
        }
        return NSClassFromString(type)
    }
    //--------------------------------------------------------------------------
    // MARK: PRIVATE PROPERTY
    //--------------------------------------------------------------------------
    private var property: objc_property_t!
}

