//
//  ViewController.swift
//  AssistiveButton
//
//  Created by zixun on 12/25/2016.
//  Copyright (c) 2016 zixun. All rights reserved.
//

import UIKit
import AssistiveButton

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.red
        
        let frame = CGRect(x: 0, y: 100, width: 48, height: 48)
        let btn = AssistiveButton(frame: frame, normalImage: UIImage(named: "test")!)
        
        btn.didTap = { () -> () in
            print("abc")
        }
        self.view.addSubview(btn)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

