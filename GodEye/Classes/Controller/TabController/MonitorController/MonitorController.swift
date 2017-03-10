//
//  MonitorViewController.swift
//  Pods
//
//  Created by zixun on 16/12/27.
//
//

import Foundation

class MonitorController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.niceBlack()
        
        self.view.addSubview(self.containerView)
        self.containerView.delegateContainer = self;
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.containerView.frame = self.view.bounds
    }
    
    private var containerView = MonitorContainerView()
}

extension MonitorController: MonitorContainerViewDelegate {
    func container(container:MonitorContainerView, didSelectedType type:MonitorSystemType) {
        
        UIAlertView.quickTip(message: "detail and historical data coming soon")
        
        if type.hasDetail {
            //TODO: add detail
            
        }
    }
}

