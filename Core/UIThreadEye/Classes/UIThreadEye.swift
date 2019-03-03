//
// Created by zixun on 2018/5/13.
// Copyright (c) 2018 zixun. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    @objc open func hook_setNeedsLayout() {
        self.checkThread()
        self.hook_setNeedsLayout()
    }
    
    @objc open func hook_setNeedsDisplay(_ rect: CGRect) {
        self.checkThread()
        self.hook_setNeedsDisplay(rect)
    }
    
    
    
    func checkThread() {
        assert(Thread.isMainThread,"You changed UI element not on main thread")
    }
}

open class UIThreadEye: NSObject {

    open class func open() {
        if self.isSwizzled == false {
            self.isSwizzled = true
            self.hook()
        }else {
            print("[NetworkEye] already started or hook failure")
        }
    }
    
    open class func close() {
        if self.isSwizzled == true {
            self.isSwizzled = false
            self.hook()
        }else {
            print("[NetworkEye] already stoped or hook failure")
        }
    }
    
    public static var isWatching: Bool  {
        get {
            return self.isSwizzled
        }
    }

    private class func hook() {
        _ = UIView.swizzleInstanceMethod(origSelector: #selector(UIView.setNeedsLayout),
                                         toAlterSelector: #selector(UIView.hook_setNeedsLayout))
        _ = UIView.swizzleInstanceMethod(origSelector: #selector(UIView.setNeedsDisplay(_:)),
                                         toAlterSelector: #selector(UIView.hook_setNeedsDisplay(_:)))
    }
    
    private static var isSwizzled: Bool {
        set{
            objc_setAssociatedObject(self, &key.isSwizzled, isSwizzled, .OBJC_ASSOCIATION_ASSIGN);
        }
        get{
            let result = objc_getAssociatedObject(self, &key.isSwizzled) as? Bool
            if result == nil {
                return false
            }
            return result!
        }
    }
    
    private struct key {
        static var isSwizzled: Character = "c"
    }
}
