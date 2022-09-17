//
//  AppDelegate.swift
//  GodEye
//
//  Created by zixun on 03/03/2019.
//  Copyright (c) 2019 zixun. All rights reserved.
//

import UIKit
import GodEye

func alert(t:String, _ m:String) {
    let alertView = UIAlertView()
    alertView.title = t
    alertView.message = m
    alertView.addButton(withTitle: "OK")
    alertView.show()
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //        GodEye.makeEye(with: self.window!)
        //
        
        
        let configuration = Configuration()
        configuration.command.add(command: "test", description: "test command") { () -> (String) in
            return "this is test command result"
        }
        configuration.command.add(command: "info", description: "print test info") { () -> (String) in
            return "info"
        }
        
        GodEye.makeEye(with: self.window!, configuration: configuration)
        return true
    }
}
