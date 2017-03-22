//
//  ViewController.swift
//  AppBaseKit
//
//  Created by 陈奕龙 on 09/24/2016.
//  Copyright (c) 2016 陈奕龙. All rights reserved.
//

import UIKit
import AppBaseKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blue
        
        self.navigationController?.pushViewController(ViewController2(), animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
}

