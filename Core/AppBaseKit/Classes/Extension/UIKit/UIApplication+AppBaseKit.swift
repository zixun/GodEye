//
//  UIApplication+AppBaseKit.swift
//  Pods
//
//  Created by zixun on 16/9/25.
//
//

import Foundation
import UIKit


// MARK: - MainWindow
extension UIApplication {
    
    public func mainWindow() -> UIWindow? {
        guard let delegate = self.delegate else {
            return self.keyWindow
        }
        
        guard delegate.responds(to: #selector(getter: UIApplicationDelegate.window)) else {
            return self.keyWindow
        }
        
        return delegate.window!
    }
}

