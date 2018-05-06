//
//  UIImage+AppBaseKit.swift
//  Pods
//
//  Created by zixun on 16/9/25.
//
//

import Foundation
import UIKit

// MARK: - Resize
extension UIImage {
    
    public func resizeImage(newSize:CGSize) -> UIImage? {
        let size = self.size
        
        let widthRatio  = newSize.width  / self.size.width
        let heightRatio = newSize.height / self.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width:size.width * widthRatio,  height:size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    public func realSize() -> CGSize {
        return CGSize(width:self.size.width * self.scale, height:self.size.height * self.scale)
    }
    
    public func isSquaresSize() -> Bool {
        let size = self.realSize()
        return size.width == size.height
    }
}


// MARK: - draw image
public extension UIImage {
    
    /// 用CGContext绘制一张图形到原来的图片中
    ///
    /// - parameter block: 绘制block
    ///
    /// - returns: 生成的新图
    public func drawGraphics(with block:(CGContext,CGRect) -> Void) -> UIImage? {
        
        let size = self.size
        let rect = CGRect(x:0, y:0, width:size.width, height:size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        self.draw(at: CGPoint.zero)
        let context: CGContext = UIGraphicsGetCurrentContext()!
        block(context,rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return image;
    }
    
    /**
     用CGContextRef代码生成一个UIImage图片对象
     
     - parameter size:         图片大小
     - parameter drawingBlock: 绘画block
     
     - returns: 生成的图片
     */
    public class func image(size: CGSize, drawingBlock:(CGContext,CGRect) -> Void) -> UIImage? {
        
        guard size.equalTo(CGSize()) == false else {
            return nil
        }
        
        let rect = CGRect(x:0, y:0, width:size.width, height:size.height)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        let context: CGContext = UIGraphicsGetCurrentContext()!
        context.clear(rect)
        
        drawingBlock(context,rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return image;
    }
    
    /**
     生成一个单一颜色的UIImage图片对象
     
     - parameter color:  颜色
     - parameter size:  大小
     
     - returns: 生成的图片对象
     */
    public class func image(color:UIColor, size:CGSize) ->UIImage? {
        
        guard size.equalTo(CGSize()) == false else {
            return nil
        }
        
        return UIImage.image(size: size) { (context:CGContext, rect:CGRect) in
            context.setFillColor(color.cgColor)
            context.fill(rect)
        }
    }
}

