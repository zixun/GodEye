//
//  ViewController.swift
//  ANREye
//
//  Created by zixun on 12/23/2016.
//  Copyright (c) 2016 zixun. All rights reserved.
//

import UIKit

import ANREye

class ViewController: UIViewController {
    private var anrEye: ANREye!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.anrEye = ANREye()
        self.anrEye.delegate = self
        self.anrEye.open(with: 1)
        var s = ""
        for _ in 0..<9999 {
            for _ in 0..<9999 {
                s.append("1")
            }
        }
        
        print("invoke")
    }
    
}

extension ViewController: ANREyeDelegate {
    
    func anrEye(anrEye:ANREye,
                catchWithThreshold threshold:Double,
                mainThreadBacktrace:String?,
                allThreadBacktrace:String?) {
        print("------------------")
        print(mainThreadBacktrace!)
        print("------------------")
        print(allThreadBacktrace!)
    }
}

