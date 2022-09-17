//
//  PreviewManager.swift
//  FileBrowser
//
//  Created by Roy Marmelstein on 16/02/2016.
//  Copyright © 2016 Roy Marmelstein. All rights reserved.
//

import Foundation
import QuickLook

class PreviewManager: NSObject, QLPreviewControllerDataSource {
    
    var filePath: URL?
    
    func previewViewControllerForFile(_ file: FBFile, fromNavigation: Bool) -> UIViewController {
        
        if file.type == .PLIST || file.type == .JSON {
#if SWIFT_PACKAGE
            let webviewPreviewViewContoller = WebviewPreviewViewContoller(nibName: nil, bundle: .module)
#else
            let webviewPreviewViewContoller = WebviewPreviewViewContoller(nibName: "WebviewPreviewViewContoller",
                                                                          bundle: Bundle(for: WebviewPreviewViewContoller.self))
#endif
            webviewPreviewViewContoller.file = file
            return webviewPreviewViewContoller
        } else {
#if SWIFT_PACKAGE
            let previewTransitionViewController = PreviewTransitionViewController(nibName: nil,
                                                                                  bundle: .module)
#else
            let previewTransitionViewController = PreviewTransitionViewController(nibName: nil,
                                                                                  bundle: Bundle(for: PreviewTransitionViewController.self))
#endif
            previewTransitionViewController.quickLookPreviewController.dataSource = self

            self.filePath = file.filePath as URL
            if fromNavigation == true {
                return previewTransitionViewController.quickLookPreviewController
            }
            return previewTransitionViewController
        }
    }
    
    
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 1
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        let item = PreviewItem()
        if let filePath = filePath {
            item.filePath = filePath
        }
        return item
    }
    
}

class PreviewItem: NSObject, QLPreviewItem {
    
    /*!
     * @abstract The URL of the item to preview.
     * @discussion The URL must be a file URL.
     */
    
    var filePath: URL?
    public var previewItemURL: URL? {
        if let filePath = filePath {
            return filePath
        }
        return nil
    }
    
}
