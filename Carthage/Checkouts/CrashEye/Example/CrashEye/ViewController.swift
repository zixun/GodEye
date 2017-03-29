//
//  ViewController.swift
//  CrashEye
//
//  Created by zixun on 12/23/2016.
//  Copyright (c) 2016 zixun. All rights reserved.
//

import UIKit
import CrashEye

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        CrashEye.add(delegate: self)
        let arr = NSArray()
        arr[10]
    }
    
}

extension ViewController: CrashEyeDelegate {
    
    func crashEyeDidCatchCrash(with model:CrashModel) {
        print(model)
    }
}

