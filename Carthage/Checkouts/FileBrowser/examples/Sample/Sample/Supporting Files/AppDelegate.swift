//
//  AppDelegate.swift
//  Sample
//
//  Created by Mihail Șalari on 9/16/16.
//  Copyright © 2016 Mihail Șalari. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.populateTableViewWithFiles()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    fileprivate func populateTableViewWithFiles() {
        let defaultsKey = "firstLaunch"
        let userDefaults = UserDefaults.standard
        let fileManager = FileManager.default
        let fileNames = ["Baymax.jpg", "BB8.jpg", "Stitch.jpg", "Info.plist"]
        let documentsUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0] as URL
        let bundleUrl = Bundle.main.resourceURL
        
        // Copy zip file to an images directory
        let imagesDirectoryURL = documentsUrl.appendingPathComponent("images")
        let zipFileName = "Images.zip"
        let imagesDirectoryPath = imagesDirectoryURL.path
        
        if userDefaults.bool(forKey: defaultsKey) == false {
            userDefaults.set(true, forKey: defaultsKey)
            userDefaults.synchronize()
            
            // Copy images to documents folder
            for file in fileNames {
                if let srcPath = bundleUrl?.appendingPathComponent(file).path {
                    let toPath = documentsUrl.appendingPathComponent(file).path
                    do {
                        try fileManager.copyItem(atPath: srcPath, toPath: toPath)
                    } catch {}
                }
            }
            
            // Copy zip file to an images directory
            do {
                try fileManager.createDirectory(atPath: imagesDirectoryPath, withIntermediateDirectories: false, attributes: nil)
                if let srcPath = bundleUrl?.appendingPathComponent(zipFileName).path {
                    let toPath = imagesDirectoryURL.appendingPathComponent(zipFileName).path
                    do {
                        try fileManager.copyItem(atPath: srcPath, toPath: toPath)
                    } catch {}
                }
            } catch {}
        }
    }
}

