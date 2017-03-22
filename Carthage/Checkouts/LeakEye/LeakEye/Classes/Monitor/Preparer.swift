//
//  Preparer.swift
//  Pods
//
//  Created by zixun on 16/12/13.
//
//

import Foundation
import AppSwizzle

//--------------------------------------------------------------------------
// MARK: - Preparer
// DESCRIPTION: Preparer for leak monitor
//--------------------------------------------------------------------------
class Preparer: NSObject {
    
    class func binding() {
        
        DispatchQueue.once { () in
            // UINavigationController
            var orig = #selector(UINavigationController.pushViewController(_:animated:))
            var alter = #selector(UINavigationController.app_pushViewController(_:animated:))
            UINavigationController.swizzleInstanceMethod(origSelector: orig, toAlterSelector: alter)
            
            
            // UIView
            orig = #selector(UIView.didMoveToSuperview)
            alter = #selector(UIView.app_didMoveToSuperview)
            UIView.swizzleInstanceMethod(origSelector: orig, toAlterSelector: alter)
            
            // UIViewController
            orig = #selector(UIViewController.present(_:animated:completion:))
            alter = #selector(UIViewController.app_present(_:animated:completion:))
            UIViewController.swizzleInstanceMethod(origSelector: orig, toAlterSelector: alter)
            
            orig = #selector(UIViewController.viewDidAppear(_:))
            alter = #selector(UIViewController.app_viewDidAppear(_:))
            UIViewController.swizzleInstanceMethod(origSelector: orig, toAlterSelector: alter)
            
        }
    }

}

//--------------------------------------------------------------------------
// MARK: - UINavigationController + Preparer
//--------------------------------------------------------------------------
extension UINavigationController {
    
    @objc fileprivate func app_pushViewController(_ viewController: UIViewController, animated: Bool) {
        self.app_pushViewController(viewController, animated: animated)
        
        viewController.makeAlive()
    }
}

//--------------------------------------------------------------------------
// MARK: - UIView + Preparer
//--------------------------------------------------------------------------
extension UIView {
    
    @objc fileprivate func app_didMoveToSuperview() {
        self.app_didMoveToSuperview()
        
        var hasAliveParent = false
        
        var r = self.next
        while (r != nil) {
            if r!.agent != nil {
                hasAliveParent = true
                break
            }
            
            r = r!.next
        }
        
        if hasAliveParent {
            self.makeAlive()
        }
    }
}

//--------------------------------------------------------------------------
// MARK: - UIViewController + Preparer
//--------------------------------------------------------------------------
extension UIViewController {
    
    @objc fileprivate func app_present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Swift.Void)? = nil) {
        self.app_present(viewControllerToPresent, animated: flag, completion: completion)
        
        viewControllerToPresent.makeAlive()
    }
    
    @objc fileprivate func app_viewDidAppear(_ animated: Bool) {
        self.app_viewDidAppear(animated)
        
        self.monitorAllRetainVariable(level: 0)
    }
}

