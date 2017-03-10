//
//  GodEyeController+Show.swift
//  Pods
//
//  Created by zixun on 16/12/27.
//
//

import Foundation
import AssistiveButton

extension GodEyeController {
    
    var animating: Bool {
        get {
            return objc_getAssociatedObject(self, &Define.Key.Associated.Animation) as? Bool ?? false
        }
        
        set {
            objc_setAssociatedObject(self, &Define.Key.Associated.Animation, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    var showing: Bool {
        get {
            return objc_getAssociatedObject(self, &Define.Key.Associated.Showing) as? Bool ?? false
        }
        
        set {
            objc_setAssociatedObject(self, &Define.Key.Associated.Showing, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    class func show() {
        self.shared.showConsole()
    }
    
    class func hide() {
        self.shared.hideConsole()
    }
    
    private func hideConsole() {
        if self.animating == false && self.view.superview != nil {
            UIApplication.shared.mainWindow()?.findAndResignFirstResponder()
            
            self.animating = true
            
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationDuration(0.4)
            UIView.setAnimationDelegate(self)
            UIView.setAnimationDidStop(#selector(GodEyeController.consoleHidden))
            self.view.frame = UIScreen.offscreenFrame()
            UIView.commitAnimations()
            
        }
    }
    
    private func showConsole() {
        if self.animating == false && self.view.superview == nil {
            UIApplication.shared.mainWindow()?.findAndResignFirstResponder()
            
            self.view.frame = UIScreen.offscreenFrame()
            self.setViewPlace()
            
            self.animating = true
            
            
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationDuration(0.4)
            UIView.setAnimationDelegate(self)
            UIView.setAnimationDidStop(#selector(GodEyeController.consoleShown))
            self.view.frame = UIScreen.onscreenFrame()
            self.view.transform = self.viewTransform()
            UIView.commitAnimations()
        }
    }
    
    @objc private func consoleShown() {
        self.showing = true
        self.animating = false
        UIApplication.shared.mainWindow()?.findAndResignFirstResponder()
    }
    
    @objc private func consoleHidden() {
        self.showing = false
        self.animating = false
        self.view.removeFromSuperview()
    }
    
    private func setViewPlace() {
        guard let superView = UIApplication.shared.mainWindow() else {
            return
        }
        superView.addSubview(self.view)
        
        //bring AssistiveButton to front
        for subview in superView.subviews {
            if subview.isKind(of: AssistiveButton.classForCoder()) {
                superView.bringSubview(toFront: subview)
            }
        }
    }
    
    private func viewTransform() -> CGAffineTransform {
        var angle: Double = 0.0
        switch UIApplication.shared.statusBarOrientation {
        case .portraitUpsideDown:
            angle = M_PI
        case .landscapeLeft:
            angle = -M_PI_2
        case .landscapeRight:
            angle = M_PI_2
        default:
            angle = 0
        }
        
        
        return CGAffineTransform(rotationAngle: CGFloat(angle))
    }
}
