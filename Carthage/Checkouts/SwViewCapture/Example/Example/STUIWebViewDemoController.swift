//
//  STUIWebViewDemoController.swift
//  Example
//
//  Created by chenxing.cx on 16/2/15.
//  Copyright © 2016年 Startry. All rights reserved.
//

import UIKit

class STUIWebViewDemoController: UIViewController {
    
    var webView: UIWebView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.red
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Capture", style: UIBarButtonItemStyle.plain, target: self, action: #selector(STUIWebViewDemoController.didCaptureBtnClicked(_:)))
        
        webView = UIWebView(frame: view.bounds)
        let url = URL(string: "http://www.startry.com")
        let request = URLRequest(url: url!)
        webView?.loadRequest(request)
        
        view.addSubview(webView!)
    }
    
    // MARK: Events
    func didCaptureBtnClicked(_ button: UIButton){
        webView?.swContentCapture({ (capturedImage) -> Void in
            
            UIImageWriteToSavedPhotosAlbum(capturedImage!, self, nil, nil)
//            
//            let vc = ImageViewController(image: capturedImage!)
//            self.navigationController?.pushViewController(vc, animated: true)
        })
        
//        webView?.swContentScrollCapture({ (capturedImage) -> Void in
//            
//            UIImageWriteToSavedPhotosAlbum(capturedImage!, self, nil, nil)
//            
//            let vc = ImageViewController(image: capturedImage!)
//            self.navigationController?.pushViewController(vc, animated: true)
//        })
    }
    
}
