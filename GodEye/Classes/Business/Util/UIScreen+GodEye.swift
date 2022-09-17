//
//  UIScreen+GodEye.swift
//  Pods
//
//  Created by zixun on 16/12/27.
//
//

import Foundation

extension UIScreen {
    class func onscreenFrame() -> CGRect {
        return self.main.applicationFrame
    }
    
    class func offscreenFrame() -> CGRect {
        var frame = self.onscreenFrame()
        switch UIApplication.shared.statusBarOrientation {
        case .portraitUpsideDown:
            frame.origin.y = -frame.size.height
        case .landscapeLeft:
            frame.origin.x = frame.size.width
        case .landscapeRight:
            frame.origin.x = -frame.size.width;
        default:
            frame.origin.y = frame.size.height
        }
        return frame
    }
}
