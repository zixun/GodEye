//
//  ViewController.swift
//  Log4G
//
//  Created by zixun on 01/10/2017.
//  Copyright (c) 2017 zixun. All rights reserved.
//

import UIKit
import Log4G


class ViewController: UIViewController,Log4GDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let btn = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        btn.backgroundColor = UIColor.yellow
        btn.setTitle("Present", for: .normal)
        btn.addTarget(self, action: #selector(ViewController.presentViewController2), for: .touchUpInside)
        self.view.addSubview(btn)
        
        let btn2 = UIButton(frame: CGRect(x: 100, y: 250, width: 100, height: 100))
        btn2.backgroundColor = UIColor.red
        btn2.setTitle("LOG", for: .normal)
        btn2.addTarget(self, action: #selector(ViewController.log), for: .touchUpInside)
        self.view.addSubview(btn2)
        
        Log4G.add(delegate: self)
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @objc private func presentViewController2() {
        self.present(ViewController2(), animated: true, completion: nil)
    }
    
    @objc private func log() {
        Log4G.log("log")
    }
    func log4gDidRecord(with model:LogModel) {
        print(model)
        print("ViewController log4gDidRecord")
    }
}



class ViewController2: UIViewController,Log4GDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.red
        
        let btn = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        btn.backgroundColor = UIColor.yellow
        btn.setTitle("Dismiss", for: .normal)
        btn.addTarget(self, action: #selector(ViewController2.dismissSelf), for: .touchUpInside)
        self.view.addSubview(btn)
        
        Log4G.add(delegate: self)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Log4G.log("ViewController2")
    }
    
    deinit {
        print("ViewController2 deinit")
    }
    
    @objc private func dismissSelf() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func log4gDidRecord(with model:LogModel) {
        print(model)
        print("ViewController2 log4gDidRecord")
    }
}
