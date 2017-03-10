//
//  NSObject+Alive.swift
//  Pods
//
//  Created by zixun on 16/12/13.
//
//

import Foundation
//--------------------------------------------------------------------------
// MARK: - NSObject+Alive
// DESCRIPTION: NSObject extension for judge if the instance is alive
//--------------------------------------------------------------------------
extension NSObject {
    
    //--------------------------------------------------------------------------
    // MARK: INTERNAL FUNCTION
    //--------------------------------------------------------------------------
    func judgeAlive() -> Bool {
        if self.isKind(of: UIViewController.classForCoder()) {
            return self.judge(controller: self as! UIViewController)
        }else if self.isKind(of: UIView.classForCoder()) {
            return self.judge(view: self as! UIView )
        }else {
            return self.judge(common: self)
        }
    }
    
    //--------------------------------------------------------------------------
    // MARK: PRIVATE FUNCTION
    //--------------------------------------------------------------------------
    
    /// judeg a comman instance is alive
    private func judge(common:NSObject) -> Bool {
        var alive = true
        if common.agent?.host == nil {
            alive = false
        }
        
        return alive
    }
    
    /// judge the controller instance is alive
    private func judge(controller:UIViewController) -> Bool {
        //1. self.view is not in the window
        //2. self is not in the navigation controllers
        
        var visiable = false
        
        var view = controller.view
        
        while ((view?.superview) != nil) {
            view = view?.superview
        }
        
        if view!.isKind(of: UIWindow.self) {
            visiable = true
        }
        
        var holdable = false
        if controller.navigationController != nil || controller.presentingViewController != nil {
            holdable = true
        }
        
        if visiable == false && holdable == false {
            return false
        }else {
            return true
        }
    }
    
    /// judge the view instance is alive
    private func judge(view:UIView) -> Bool {
        
        var alive = true
        var onUIStack = false
        var v = view
        
        while v.superview != nil {
            v = v.superview!
        }
        
        if v.isKind(of: UIWindow.classForCoder()) {
            onUIStack = true
        }
        
        if view.agent?.responder == nil {
            var r = view.next
            while r != nil {
                if r!.next == nil {
                    break
                }else {
                    r = r!.next
                }
                
                if (r?.isKind(of: UIViewController.classForCoder()))! {
                    break
                }
            }
            view.agent?.responder = r
        }
        
        if onUIStack == false {
            alive = false
            if let r = view.agent?.responder  {
                alive = r.isKind(of: UIViewController.classForCoder())
            }
        }
        return alive
    }
}
