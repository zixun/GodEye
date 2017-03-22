//
//  WKWebView+SwCapture.swift
//  SwViewCapture
//
//  Created by chenxing.cx on 16/2/19.
//  Copyright © 2016年 Startry. All rights reserved.
//

import Foundation
import WebKit
import ObjectiveC

public extension WKWebView {
    
    public func swContentCapture(_ completionHandler:@escaping (_ capturedImage: UIImage?) -> Void) {
        
        self.isCapturing = true
        
        let offset = self.scrollView.contentOffset
        
        // Put a fake Cover of View
        let snapShotView = self.snapshotView(afterScreenUpdates: true)
        snapShotView?.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: (snapShotView?.frame.size.width)!, height: (snapShotView?.frame.size.height)!)
        self.superview?.addSubview(snapShotView!)
        
        if self.frame.size.height < self.scrollView.contentSize.height {
            self.scrollView.contentOffset = CGPoint(x: 0, y: self.scrollView.contentSize.height - self.frame.size.height)
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(0.3 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)) { () -> Void in
            self.scrollView.contentOffset = CGPoint.zero
            
            self.swContentCaptureWithoutOffset({ [weak self] (capturedImage) -> Void in
                let strongSelf = self!
                
                strongSelf.scrollView.contentOffset = offset
                
                snapShotView?.removeFromSuperview()
                
                strongSelf.isCapturing = false
                
                completionHandler(capturedImage)
            })
        }
    }
    
    fileprivate func swContentCaptureWithoutOffset(_ completionHandler:@escaping (_ capturedImage: UIImage?) -> Void) {
        let containerView  = UIView(frame: self.bounds)
        
        let bakFrame     = self.frame
        let bakSuperView = self.superview
        let bakIndex     = self.superview?.subviews.index(of: self)
        
        // remove WebView from superview & put container view
        self.removeFromSuperview()
        containerView.addSubview(self)
        
        let totalSize = self.scrollView.contentSize
        
        // Divide
        let page       = floorf(Float( totalSize.height / containerView.bounds.height))
        
        self.frame = CGRect(x: 0, y: 0, width: containerView.bounds.size.width, height: self.scrollView.contentSize.height)

        UIGraphicsBeginImageContextWithOptions(totalSize, false, UIScreen.main.scale)
        
        self.swContentPageDraw(containerView, index: 0, maxIndex: Int(page), drawCallback: { [weak self] () -> Void in
            let strongSelf = self!
            
            let capturedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            // Recover
            strongSelf.removeFromSuperview()
            bakSuperView?.insertSubview(strongSelf, at: bakIndex!)
            
            strongSelf.frame = bakFrame
            
            containerView.removeFromSuperview()
            
            completionHandler(capturedImage)
        })
    }
    
    fileprivate func swContentPageDraw (_ targetView: UIView, index: Int, maxIndex: Int, drawCallback: @escaping () -> Void) {
        
        // set up split frame of super view
        let splitFrame = CGRect(x: 0, y: CGFloat(index) * targetView.frame.size.height, width: targetView.bounds.size.width, height: targetView.frame.size.height)
        // set up webview frame
        var myFrame = self.frame
        myFrame.origin.y = -(CGFloat(index) * targetView.frame.size.height)
        self.frame = myFrame
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(0.3 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)) { () -> Void in
            targetView.drawHierarchy(in: splitFrame, afterScreenUpdates: true)
            
            if index < maxIndex {
                self.swContentPageDraw(targetView, index: index + 1, maxIndex: maxIndex, drawCallback: drawCallback)
            }else{
                drawCallback()
            }
        }
    }
    

    // Simulate People Action, all the `fixed` element will be repeate
    // SwContentCapture will capture all content without simulate people action, more perfect.
    public func swContentScrollCapture (_ completionHandler: @escaping (_ capturedImage: UIImage?) -> Void) {
        
        self.isCapturing = true
        
        // Put a fake Cover of View
        let snapShotView = self.snapshotView(afterScreenUpdates: true)
        snapShotView?.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: (snapShotView?.frame.size.width)!, height: (snapShotView?.frame.size.height)!)
        self.superview?.addSubview(snapShotView!)
        
        // Backup
        let bakOffset    = self.scrollView.contentOffset
        
        // Divide
        let page  = floorf(Float(self.scrollView.contentSize.height / self.bounds.height))
        
        UIGraphicsBeginImageContextWithOptions(self.scrollView.contentSize, false, UIScreen.main.scale)
        
        self.swContentScrollPageDraw(0, maxIndex: Int(page), drawCallback: { [weak self] () -> Void in
            let strongSelf = self
            
            let capturedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            // Recover
            strongSelf?.scrollView.setContentOffset(bakOffset, animated: false)
            snapShotView?.removeFromSuperview()
            
            strongSelf?.isCapturing = false
            
            completionHandler(capturedImage)
        })
        
    }
    
    fileprivate func swContentScrollPageDraw (_ index: Int, maxIndex: Int, drawCallback: @escaping () -> Void) {
        
        self.scrollView.setContentOffset(CGPoint(x: 0, y: CGFloat(index) * self.scrollView.frame.size.height), animated: false)
        let splitFrame = CGRect(x: 0, y: CGFloat(index) * self.scrollView.frame.size.height, width: bounds.size.width, height: bounds.size.height)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(0.3 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)) { () -> Void in
            self.drawHierarchy(in: splitFrame, afterScreenUpdates: true)
            
            if index < maxIndex {
                self.swContentScrollPageDraw(index + 1, maxIndex: maxIndex, drawCallback: drawCallback)
            }else{
                drawCallback()
            }
        }
    }
}
