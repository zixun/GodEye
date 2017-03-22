//
//  SecondViewController.swift
//  LeakEye
//
//  Created by zixun on 16/12/26.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

class LeakTest: NSObject {
    
    var block: (() -> ())!
    
    init(block: @escaping () -> () ) {
        super.init()
        self.block = block
    }
}

class SecondViewController: UIViewController {
    
    private var test : LeakTest!
    
    private var str: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let btn = UIButton(frame: CGRect(x: 200, y: 100, width: 100, height: 100))
        btn.setTitle("Pop", for: UIControlState.normal)
        btn.setTitleColor(UIColor.red, for: UIControlState.normal)
        btn.addTarget(self, action: #selector(SecondViewController.pop), for: UIControlEvents.touchUpInside)
        self.view.addSubview(btn)
        
        self.test = LeakTest {
            self.str.append("leak")
        }
        
    }
    
    func pop()  {
        _ = self.navigationController?.popViewController(animated: true)
        
    }
    
    deinit {
        print("deinit")
    }
}
