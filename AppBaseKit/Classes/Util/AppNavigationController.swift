//
//  AppNavigationController.swift
//  Pods
//
//  Created by zixun on 2016/10/24.
//
//

import UIKit

public class AppNavigationController: UINavigationController {
    
    public var enable = true
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        // 获取系统自带滑动手势的target对象
        let target = self.interactivePopGestureRecognizer!.delegate;
        
        // 创建全屏滑动手势，调用系统自带滑动手势的target的action方法
        let pan = UIPanGestureRecognizer(target: target, action: Selector("handleNavigationTransition:"))
        
        // 设置手势代理，拦截手势触发
        pan.delegate = self;
        
        // 给导航控制器的view添加全屏滑动手势
        self.view.addGestureRecognizer(pan);
        
        // 禁止使用系统自带的滑动手势
        self.interactivePopGestureRecognizer!.isEnabled = false;
    }
    
    override public func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if self.viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
}

// MARK: UIGestureRecognizerDelegate
extension AppNavigationController: UIGestureRecognizerDelegate {
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let translation: CGPoint = (gestureRecognizer as! UIPanGestureRecognizer).translation(in: self.view.superview)
        
        guard self.enable == true else {
            return false
        }
        
        if (translation.x < 0) {
            return false //往右滑返回，往左滑不做操作
        }
        
        if (self.viewControllers.count <= 1) {
            return false
        }
        return true
    }
}
