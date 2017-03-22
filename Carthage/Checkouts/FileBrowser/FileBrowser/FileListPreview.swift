//
//  FileListPreview.swift
//  FileBrowser
//
//  Created by Roy Marmelstein on 13/02/2016.
//  Copyright © 2016 Roy Marmelstein. All rights reserved.
//

import Foundation
import QuickLook

extension FileListViewController: UIViewControllerPreviewingDelegate {
    
    //MARK: UIViewControllerPreviewingDelegate
    
    func registerFor3DTouch() {
        if #available(iOS 9.0, *) {
            if self.traitCollection.forceTouchCapability == UIForceTouchCapability.available {
                registerForPreviewing(with: self, sourceView: tableView)
            }
        }
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        if #available(iOS 9.0, *) {
            if let indexPath = tableView.indexPathForRow(at: location) {
                let selectedFile = fileForIndexPath(indexPath)
                previewingContext.sourceRect = tableView.rectForRow(at: indexPath)
                if selectedFile.isDirectory == false {
                    return previewManager.previewViewControllerForFile(selectedFile, fromNavigation: false)
                }
            }
        }
        return nil
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        if let previewTransitionViewController = viewControllerToCommit as? PreviewTransitionViewController {
            self.navigationController?.pushViewController(previewTransitionViewController.quickLookPreviewController, animated: true)
        }
        else {
            self.navigationController?.pushViewController(viewControllerToCommit, animated: true)
        }

    }
    
}

