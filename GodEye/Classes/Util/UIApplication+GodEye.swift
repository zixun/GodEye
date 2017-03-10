//
//  UIApplication+GodEye.swift
//  Pods
//
//  Created by zixun on 16/12/27.
//
//

import Foundation

extension UIApplication {
    
    func mainWindow() -> UIWindow? {
        
        guard let delegate = self.delegate else {
            return self.keyWindow
        }
        
        guard let window = delegate.window  else {
            return self.keyWindow
        }
        
        return window
        
    }
}
