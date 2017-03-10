//
//  GodEyeController.swift
//  Pods
//
//  Created by zixun on 16/12/27.
//
//

import Foundation
import FileBrowser
import AppBaseKit

class GodEyeController: UITabBarController {
    
    static let shared = GodEyeController()
    
    var configuration: Configuration! {
        didSet {
            /// because the `viewControllers` will use configuration,
            /// but `GodEyeController.shared.configuration` will call 
            /// `viewDidLoad` first,then call the `didSet`
            self.viewControllers = [self.consoleVC,self.monitorVC,self.fileVC,self.settingVC]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
        
        self.selectedIndex = 0
        self.tabBar.barTintColor = UIColor.black
    }
    
    lazy var consoleVC: UINavigationController = {
        let new = UINavigationController(rootViewController:ConsoleController())
        new.tabBarItem = UITabBarItem(title: "Console", image: nil, selectedImage: nil)
        new.isNavigationBarHidden = true
        new.hidesBottomBarWhenPushed = true
        return new
    }()
    
    lazy var monitorVC: UINavigationController = {
        let new = UINavigationController(rootViewController: MonitorController())
        new.tabBarItem = UITabBarItem(title: "Monitor", image: nil, selectedImage: nil)
        new.isNavigationBarHidden = true
        new.hidesBottomBarWhenPushed = true
        return new
    }()
    
    lazy var fileVC: UINavigationController = {
        let new = UINavigationController(rootViewController: FileController())  //FileBrowser(initialPath: url!)
        new.tabBarItem = UITabBarItem(title: "File", image: nil, selectedImage: nil)
        new.isNavigationBarHidden = true
        new.hidesBottomBarWhenPushed = true
        return new
    }()
    
    lazy var settingVC: UINavigationController = {
        let new = UINavigationController(rootViewController: SettingController())
        new.tabBarItem = UITabBarItem(title: "Setting", image: nil, selectedImage: nil)
        new.isNavigationBarHidden = true
        new.hidesBottomBarWhenPushed = true
        return new
    }()
}
