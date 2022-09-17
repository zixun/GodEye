//
//  PreviewTransitionViewController.swift
//  FileBrowser
//
//  Created by Roy Marmelstein on 16/02/2016.
//  Copyright © 2016 Roy Marmelstein. All rights reserved.
//

import UIKit
import QuickLook

/// Preview Transition View Controller was created because of a bug in QLPreviewController. It seems that QLPreviewController has issues being presented from a 3D touch peek-pop gesture and is produced an unbalanced presentation warning. By wrapping it in a container, we are solving this issue.
class PreviewTransitionViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    
    let quickLookPreviewController = QLPreviewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addChild(quickLookPreviewController)
        containerView.addSubview(quickLookPreviewController.view)
        quickLookPreviewController.view.frame = containerView.bounds
        quickLookPreviewController.didMove(toParent: self)
    }

}
