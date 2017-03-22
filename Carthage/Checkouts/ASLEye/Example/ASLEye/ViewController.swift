//
//  ViewController.swift
//  ASLEye
//
//  Created by zixun on 12/25/2016.
//  Copyright (c) 2016 zixun. All rights reserved.
//

import UIKit
import ASLEye

class ViewController: UIViewController {

    var aslEye: ASLEye!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSLog("abb")
        self.aslEye = ASLEye()
        self.aslEye.delegate = self
        self.aslEye.open(with: 2)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 4) {
            NSLog("2")
        }
    }

}

extension ViewController: ASLEyeDelegate {
    func aslEye(aslEye:ASLEye,catchLogs logs:[String]) {
        print(logs)
    }
}
