//
//  AppSwizzle.swift
//  Pods
//
//  Created by zixun on 2016/11/27.
//
//

import Foundation

import ObjectiveC

public enum SwizzleResult {
    case Succeed
    case OriginMethodNotFound
    case AlternateMethodNotFound
}

public extension NSObject {
    
    public class func swizzleInstanceMethod(origSelector: Selector,
                                            toAlterSelector alterSelector: Selector) -> SwizzleResult {
        return self.swizzleMethod(origSelector: origSelector,
                                  toAlterSelector: alterSelector,
                                  inAlterClass: self.classForCoder(),
                                  isClassMethod: false)
    }
    
    public class func swizzleClassMethod(origSelector: Selector,
                                         toAlterSelector alterSelector: Selector) -> SwizzleResult {
        return self.swizzleMethod(origSelector: origSelector,
                                  toAlterSelector: alterSelector,
                                  inAlterClass: self.classForCoder(),
                                  isClassMethod: true)
    }
    
    
    public class func swizzleInstanceMethod(origSelector: Selector,
                                            toAlterSelector alterSelector: Selector,
                                            inAlterClass alterClass: AnyClass) -> SwizzleResult {
        return self.swizzleMethod(origSelector: origSelector,
                                  toAlterSelector: alterSelector,
                                  inAlterClass: alterClass,
                                  isClassMethod: false)
    }
    
    public class func swizzleClassMethod(origSelector: Selector,
                                         toAlterSelector alterSelector: Selector,
                                         inAlterClass alterClass: AnyClass) -> SwizzleResult {
        return self.swizzleMethod(origSelector: origSelector,
                                  toAlterSelector: alterSelector,
                                  inAlterClass: alterClass,
                                  isClassMethod: true)
    }
    
    
    private class func swizzleMethod(origSelector: Selector,
                                     toAlterSelector alterSelector: Selector!,
                                     inAlterClass alterClass: AnyClass!,
                                     isClassMethod:Bool) -> SwizzleResult {
        
        var alterClass = alterClass
        var origClass: AnyClass = self.classForCoder()
        if isClassMethod {
            alterClass = object_getClass(alterClass)
            origClass = object_getClass(self.classForCoder())
        }
        
        return SwizzleMethod(origClass: origClass, origSelector: origSelector, toAlterSelector: alterSelector, inAlterClass: alterClass)
    }
}


private func SwizzleMethod(origClass:AnyClass!,origSelector: Selector,toAlterSelector alterSelector: Selector!,inAlterClass alterClass: AnyClass!) -> SwizzleResult{
    
    guard  let origMethod: Method = class_getInstanceMethod(origClass, origSelector) else {
        return SwizzleResult.OriginMethodNotFound
    }
    
    guard let altMethod: Method = class_getInstanceMethod(alterClass, alterSelector) else {
        return SwizzleResult.AlternateMethodNotFound
    }
    
    
    
    let didadd = class_addMethod(origClass,
                                 origSelector,method_getImplementation(origMethod),
                                 method_getTypeEncoding(origMethod))
    
    
    let didadd2 = class_addMethod(alterClass,
                                  alterSelector,method_getImplementation(altMethod),
                                  method_getTypeEncoding(altMethod))
    
    method_exchangeImplementations(origMethod, altMethod)
    
    return SwizzleResult.Succeed
    
}
