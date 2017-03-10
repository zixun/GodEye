//
//  UIView+GodEye.swift
//  Pods
//
//  Created by zixun on 16/12/27.
//
//

import Foundation

extension UIView {
    
    func findAndResignFirstResponder() -> Bool {
        
        if self.isFirstResponder {
            self.resignFirstResponder()
            return true
        }
        
        for subview in self.subviews {
            if subview.findAndResignFirstResponder() {
                return true
            }
            
        }
        
        return false
    }
}
