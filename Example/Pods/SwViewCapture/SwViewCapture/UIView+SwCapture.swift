//
//  UIView+SwCapture.swift
//  SwViewCapture
//
//  Created by chenxing.cx on 16/2/17.
//  Copyright © 2016年 Startry. All rights reserved.
//

import UIKit
import WebKit
import ObjectiveC

private var SwViewCaptureKey_IsCapturing: String = "SwViewCapture_AssoKey_isCapturing"

public extension UIView {
    
    public func swSetFrame(_ frame: CGRect) {
        // Do nothing, use for swizzling
    }
    
    var isCapturing:Bool! {
        get {
            let num =  objc_getAssociatedObject(self, &SwViewCaptureKey_IsCapturing)
            if num == nil {
                return false
            }
            
//            num as AnyObject .boolValue
            return false
            
//            return num.boolValue
        }
        set(newValue) {
            let num = NSNumber(value: newValue as Bool)
            objc_setAssociatedObject(self, &SwViewCaptureKey_IsCapturing, num, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    // Ref: chromium source - snapshot_manager, fix wkwebview screenshot bug.
    // https://chromium.googlesource.com/chromium/src.git/+/46.0.2478.0/ios/chrome/browser/snapshots/snapshot_manager.mm
    public func swContainsWKWebView() -> Bool {
        if self.isKind(of: WKWebView.self) {
            return true
        }
        for subView in self.subviews {
            if (subView.swContainsWKWebView()) {
                return true
            }
        }
        return false
    }
    
    public func swCapture(_ completionHandler: (_ capturedImage: UIImage?) -> Void) {
        
        self.isCapturing = true
        
        let bounds = self.bounds
        
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        
        let context = UIGraphicsGetCurrentContext()
        context?.saveGState()
        context?.translateBy(x: -self.frame.origin.x, y: -self.frame.origin.y);
        
        if (swContainsWKWebView()) {
            self.drawHierarchy(in: bounds, afterScreenUpdates: true)
        }else{
            self.layer.render(in: context!)
        }
        let capturedImage = UIGraphicsGetImageFromCurrentImageContext()
        
        context?.restoreGState();
        UIGraphicsEndImageContext()
        
        self.isCapturing = false
        
        completionHandler(capturedImage)
    }
}

