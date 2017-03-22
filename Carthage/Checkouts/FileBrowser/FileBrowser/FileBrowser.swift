//
//  FileBrowser.swift
//  FileBrowser
//
//  Created by Roy Marmelstein on 14/02/2016.
//  Copyright © 2016 Roy Marmelstein. All rights reserved.
//

import Foundation

/// File browser containing navigation controller.
open class FileBrowser: UINavigationController {
    
    let parser = FileParser.sharedInstance
    
    var fileList: FileListViewController?

    /// File types to exclude from the file browser.
    open var excludesFileExtensions: [String]? {
        didSet {
            parser.excludesFileExtensions = excludesFileExtensions
        }
    }
    
    /// File paths to exclude from the file browser.
    open var excludesFilepaths: [URL]? {
        didSet {
            parser.excludesFilepaths = excludesFilepaths
        }
    }
    
    /// Override default preview and actionsheet behaviour in favour of custom file handling.
    open var didSelectFile: ((FBFile) -> ())? {
        didSet {
            fileList?.didSelectFile = didSelectFile
        }
    }
    
    /**
     Init to documents folder.
     
     - returns: File browser view controller.
     */
    public convenience init() {
        let parser = FileParser.sharedInstance
        let path = parser.documentsURL()
        self.init(initialPath: path as URL)
    }
    
    /**
     Init to a custom directory path.
     
     - parameter initialPath: NSURL filepath to containing directory.
     
     - returns: File browser view controller.
     */
    public convenience init(initialPath: URL) {
        let fileListViewController = FileListViewController(initialPath: initialPath)
        self.init(rootViewController: fileListViewController)
        self.view.backgroundColor = UIColor.white
        self.fileList = fileListViewController
    }
    
}
