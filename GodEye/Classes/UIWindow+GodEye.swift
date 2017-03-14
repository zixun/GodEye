//
//  UIWindow+GodEye.swift
//  Pods
//
//  Created by zixun on 16/12/27.
//
//

import Foundation
import AssistiveButton
import AppSwizzle

extension UIWindow {
    
    fileprivate class var hookWindow: UIWindow? {
        get {
            return objc_getAssociatedObject(self, &Define.Key.Associated.HookWindow) as? UIWindow
        }
        set {
            objc_setAssociatedObject(self, &Define.Key.Associated.HookWindow, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    func makeEye(with configuration:Configuration) {
        GodEyeController.shared.configuration = configuration
        
        let rect = CGRect(x: self.frame.size.width - 48, y: self.frame.size.height - 160, width: 48, height: 48)
        
        let image = UIImage(named: "GodEye.bundle/eye", in: Bundle(for: GodEyeController.classForCoder()), compatibleWith: nil)
        let btn = AssistiveButton(frame: rect, normalImage: image!)
        btn.didTap = { () -> () in
            if GodEyeController.shared.showing {
                GodEyeController.hide()
            }else {
                GodEyeController.show()
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) {
            self.addSubview(btn)
        }
        
        UIWindow.hookWindow = self
        
        var orig = #selector(UIWindow.sendEvent(_:))
        var alter = #selector(UIWindow.app_sendEvent(_:))
        UIWindow.swizzleInstanceMethod(origSelector: orig, toAlterSelector: alter)
        
        
        orig = #selector(UIResponder.motionEnded(_:with:))
        alter = #selector(UIResponder.app_motionEnded(_:with:))
        UIResponder.swizzleInstanceMethod(origSelector: orig, toAlterSelector: alter)
    }
    
    
}

extension UIResponder {
    func app_motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        let control = GodEyeController.shared.configuration.control
        if control.enabled && control.shakeToShow() {
            if event?.type == UIEventType.motion && event?.subtype == UIEventSubtype.motionShake {
                if GodEyeController.shared.showing {
                    GodEyeController.hide()
                }else {
                    GodEyeController.show()
                }
            }
        }
        self.app_motionEnded(motion, with: event)
    }
}

extension UIWindow {
    
    
    @objc fileprivate func app_sendEvent(_ event: UIEvent) {
        if self.canHandle(event: event) {
            self.handle(event: event)
        }
        
        self.app_sendEvent(event)
    }
    
    private func canHandle(event:UIEvent) -> Bool {
        
        if UIWindow.hookWindow == self {
            let control = GodEyeController.shared.configuration.control
            
            if control.enabled && event.type == .touches {
                let touches = event.allTouches
                
                if touches?.count == control.touchesToShow() {
                    return true
                }
            }
        }
        
        return false
    }
    
    private func handle(event:UIEvent) {
        guard let touches = event.allTouches else {
            return
        }
        
        var allUp = true; var allDown = true; var allLeft = true; var allRight = true
        
        touches.forEach { (touch:UITouch) in
            
            if touch.location(in: self).y <= touch.previousLocation(in: self).y {
                allDown = false
            }
            
            if touch.location(in: self).y >= touch.previousLocation(in: self).y {
                allUp = false
            }
            
            if touch.location(in: self).x <= touch.previousLocation(in: self).x {
                allLeft = false
            }
            
            if touch.location(in: self).x >= touch.previousLocation(in: self).x {
                allRight = false
            }
        }
        
        switch UIApplication.shared.statusBarOrientation {
        case .portraitUpsideDown:
            self.handleConsole(show: allDown, hide: allUp)
        case .landscapeLeft:
            self.handleConsole(show: allRight, hide: allLeft)
        case .landscapeRight:
            self.handleConsole(show: allLeft, hide: allRight)
        default:
            self.handleConsole(show: allUp, hide: allDown)
        }
    }
    
    private func handleConsole(show:Bool,hide:Bool) {
        if show {
            GodEyeController.show()
        }else if hide {
            GodEyeController.hide()
        }
    }
}
