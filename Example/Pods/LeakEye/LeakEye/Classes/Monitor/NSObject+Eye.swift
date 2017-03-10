//
//  NSObject+Monitor.swift
//  Pods
//
//  Created by zixun on 16/12/12.
//
//

import Foundation

//--------------------------------------------------------------------------
// MARK: - NSObject agent extension
//--------------------------------------------------------------------------
extension NSObject {
    private struct key {
        static var objectAgent = "\(#file)+\(#line)"
    }
    
    var agent: ObjectAgent? {
        get {
            return objc_getAssociatedObject(self, &key.objectAgent) as? ObjectAgent
        }
        set {
            objc_setAssociatedObject(self, &key.objectAgent, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

//--------------------------------------------------------------------------
// MARK: - NSObject monitor extension
//--------------------------------------------------------------------------
extension NSObject {
    
    /// monitor all retain variable of the NSObject instance
    ///
    /// - Parameter level: extend chain level
    func monitorAllRetainVariable(level: Int) {
        if level >= 5 {
            return
        }
        
        var monitorVariables = [String]()
        
        //track class level1
        if self.isSystemClass(clazz: self.classForCoder) == false {
            let var_level1 = self.getAllVariableName(cls: self.classForCoder)
            monitorVariables.append(contentsOf: var_level1)
        }
        
        if self.isSystemClass(clazz: self.superclass) {
            let var_level2 = self.getAllVariableName(cls: self.superclass!)
            monitorVariables.append(contentsOf: var_level2)
        }
        
        if self.isSystemClass(clazz: self.superclass?.superclass()) {
            let var_level3 = self.getAllVariableName(cls: self.superclass!.superclass()!)
            monitorVariables.append(contentsOf: var_level3)
        }
        
        for name in monitorVariables {
            
            guard let cur = self.value(forKey: name) else {
                continue
            }
            
            guard let obj = cur as? NSObject else {
                continue
            }
            
            let ret = obj.makeAlive()
            if ret {
                obj.agent?.host = self
                obj.monitorAllRetainVariable(level: level+1)
            }
        }
    }
    
    private func getAllVariableName(cls:AnyClass) -> [String] {
        
        let count = UnsafeMutablePointer<UInt32>.allocate(capacity: 0)
        let properties = class_copyPropertyList(cls, count)
        
        if Int(count[0]) == 0 {
            free(properties)
            return [String]()
        }
        
        var result = [String]()
        for i in 0..<Int(count[0]) {
            
            guard let property = properties?[i] else {
                continue
            }
            let variable = Variable(property: property)
            guard let type = variable.type() else {
                continue
            }
            if type == self.classForCoder {
                continue
            }
            if variable.isStrong() == false {
                continue
            }
            result.append(variable.name())
        }
        
        free(properties)
        return result
    }
}
//--------------------------------------------------------------------------
// MARK: - NSObject live extension
//--------------------------------------------------------------------------
extension NSObject {
    /// warp of the judgeAlive api
    func isAlive() -> Bool {
        return self.judgeAlive()
    }
    
    /// labeled the object is alive
    func makeAlive() -> Bool {
        //agent mask be nil
        if self.agent != nil {
            return false
        }
        //not check system class
        if self.isSystemClass(clazz: self.classForCoder) {
            return false
        }
        //view object needs a super view ti be alive 
        if self.isKind(of: UIView.classForCoder()) {
            let v: UIView = self as! UIView
            if v.superview == nil {
                return false
            }
        }
        //view controller need in the navigation or presenting
        if self.isKind(of: UIViewController.classForCoder()) {
            let vc: UIViewController = self as! UIViewController
            if vc.navigationController == nil && vc.presentingViewController == nil {
                return false
            }
        }
        self.agent = ObjectAgent(object: self)
        return true
    }

    /// judeg the specified class is one of the system class
    func isSystemClass(clazz:AnyClass?) -> Bool {
        
        guard let clazz = clazz else {
            return false
        }
        
        let bundle = Bundle(for: clazz)
        
        guard bundle.bundlePath.hasSuffix("/usr/lib") == false else {
            return true
        }
        
        //need below /usr/lib check, because "/usr/lib" bundle also has no bundleIdentifier
        guard let bundleIdentifier = bundle.bundleIdentifier else {
            return false
        }
        
        if bundleIdentifier.hasPrefix("com.apple."){
            return true
        }else {
            return false
        }
    }
    
}
