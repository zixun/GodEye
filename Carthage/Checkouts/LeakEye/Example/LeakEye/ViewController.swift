//
//  ViewController.swift
//  LeakEye
//
//  Created by zixun on 12/26/2016.
//  Copyright (c) 2016 zixun. All rights reserved.
//

import UIKit
import LeakEye

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let btn = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        btn.setTitle("Push", for: UIControlState.normal)
        btn.setTitleColor(UIColor.red, for: UIControlState.normal)
        btn.addTarget(self, action: #selector(ViewController.push), for: UIControlEvents.touchUpInside)
        self.view.addSubview(btn)
        
    }

    func push() {
        self.navigationController?.pushViewController(SecondViewController(), animated: true)
    }

}

