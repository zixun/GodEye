//
//  AppDelegate.swift
//  LeakEye
//
//  Created by zixun on 12/26/2016.
//  Copyright (c) 2016 zixun. All rights reserved.
//

import UIKit
import LeakEye

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var eye = LeakEye()
  
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.eye.delegate = self
        self.eye.start()
        
        return true
    }
}

extension AppDelegate: LeakEyeDelegate {
    func leakEye(leakEye:LeakEye,didCatchLeak object:NSObject) {
        print(object)
    }
    
}

