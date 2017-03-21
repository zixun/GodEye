//
//  STViewDemoController.swift
//  STViewCapture
//
//  Created by chenxing.cx on 10/28/2015.
//  Copyright (c) 2015 startry.com All rights reserved.
//

import UIKit
import SwViewCapture

class STViewDemoController: UIViewController {
    
// MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.yellow
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Capture", style: UIBarButtonItemStyle.plain, target: self, action: #selector(STViewDemoController.didCaptureBtnClicked(_:)))
        
        // Add Some Color View for Capture
        let orangeView = UIView(frame: CGRect(x: 100, y: 100, width: 20, height: 50))
        let redView = UIView(frame: CGRect(x: 150, y: 200, width: 100, height: 100))
        
        let headImage = UIImage(named: "demo_2")
        let headImageView = UIImageView(frame: CGRect(x: 30, y: 300, width: headImage!.size.width, height: headImage!.size.height))
        headImageView.image = headImage
        
        orangeView.backgroundColor = UIColor.orange
        redView.backgroundColor = UIColor.red
        
        view.addSubview(orangeView)
        view.addSubview(redView)
        view.addSubview(headImageView)
    }
    
// MARK: Events
    
    func didCaptureBtnClicked(_ button: UIButton){
        
        view.swCapture { (capturedImage) -> Void in
            let vc = ImageViewController(image: capturedImage!)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

