//
//  STScrollViewDemoController.swift
//  STViewCapture
//
//  Created by chenxing.cx on 15/10/28.
//  Copyright © 2015年 startry.com All rights reserved.
//

import UIKit
import WebKit

class STScrollViewDemoController: UIViewController {
        
    // MARK: Life Cycle
    
    var scrollView: UIScrollView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Capture", style: UIBarButtonItemStyle.plain, target: self, action: #selector(STScrollViewDemoController.didCaptureBtnClicked(_:)))
        
        // Add Some Color View for Capture
        let orangeView = UIView(frame: CGRect(x: 30, y: 100, width: 100, height: 100))
        let redView = UIView(frame: CGRect(x: 30, y: 200, width: 100, height: 100))
        
        let headImage = UIImage(named: "demo_2")
        let headImageView = UIImageView(frame: CGRect(x: 30, y: 300, width: headImage!.size.width / 2, height: headImage!.size.height / 2))
        headImageView.image = headImage
        
        let sceneImage = UIImage(named: "demo_1")
        let sceneImageView = UIImageView(frame: CGRect(x: 30, y: 500, width: sceneImage!.size.width / 2, height: sceneImage!.size.height / 2))
        sceneImageView.image = sceneImage
        
        let url = URL(string: "http://www.startry.com")
        let request = URLRequest(url: url!)
        let webView = WKWebView(frame: CGRect(x: 0, y: 600, width: self.view.frame.size.width, height: 100))
        webView.load(request)
            
        orangeView.backgroundColor = UIColor.orange
        redView.backgroundColor = UIColor.red
        
        scrollView = UIScrollView()
        scrollView?.backgroundColor = UIColor.orange
        scrollView?.contentSize = CGSize(width: view.bounds.width, height: 800)
        
        scrollView?.addSubview(orangeView)
        scrollView?.addSubview(redView)
        scrollView?.addSubview(headImageView)
        scrollView?.addSubview(sceneImageView)
        scrollView?.addSubview(webView)
        
        view.addSubview(scrollView!)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView?.frame = view.bounds
    }
    
    // MARK: Events
    
    func didCaptureBtnClicked(_ button: UIButton){
        
        scrollView?.swContentCapture({ (capturedImage) -> Void in
            
            UIImageWriteToSavedPhotosAlbum(capturedImage!, self, nil, nil)
            
            let vc = ImageViewController(image: capturedImage!)
            self.navigationController?.pushViewController(vc, animated: true)
        })
        
//        scrollView?.swContentScrollCapture({ (capturedImage) -> Void in
//            
//            UIImageWriteToSavedPhotosAlbum(capturedImage!, self, nil, nil)
//            
//            let vc = ImageViewController(image: capturedImage!)
//            self.navigationController?.pushViewController(vc, animated: true)
//        })
    }
    
}
