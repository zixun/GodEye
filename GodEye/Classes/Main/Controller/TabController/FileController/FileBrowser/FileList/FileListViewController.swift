//
//  FileListViewController.swift
//  FileBrowser
//
//  Created by Roy Marmelstein on 12/02/2016.
//  Copyright © 2016 Roy Marmelstein. All rights reserved.
//

import UIKit

class FileListViewController: UIViewController {
    
    // TableView
    @IBOutlet weak var tableView: UITableView!
    let collation = UILocalizedIndexedCollation.current()
    
    /// Data
    var didSelectFile: ((FBFile) -> ())?
    var didClose: (() -> ())?
    var files = [FBFile]()
    var initialPath: URL?
    let parser = FileParser.sharedInstance
    let previewManager = PreviewManager()
    var sections: [[FBFile]] = []
    var allowEditing: Bool = false
    var showSize: Bool = false

    // Search controller
    var filteredFiles = [FBFile]()
    let searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.searchBarStyle = .minimal
        searchController.searchBar.backgroundColor = UIColor.fileBrowserBackground()
        searchController.dimsBackgroundDuringPresentation = false
        return searchController
    }()
    
    
    //MARK: Lifecycle
    convenience init (initialPath: URL, allowEditing: Bool = false) {
        self.init(initialPath: initialPath, showCancelButton: true, allowEditing: allowEditing)
    }
    
    convenience init (initialPath: URL, showCancelButton: Bool, allowEditing: Bool = false, showSize: Bool = false) {
#if SWIFT_PACKAGE
        self.init(nibName: nil, bundle: .module)
#else
        self.init(nibName: "FileListViewController", bundle: Bundle(for: FileListViewController.self))
#endif
        self.edgesForExtendedLayout = UIRectEdge()
        
        // Set initial path
        self.initialPath = initialPath
        self.title = initialPath.lastPathComponent
        self.allowEditing = allowEditing
        self.showSize = showSize

        // Set search controller delegates
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.delegate = self
        
        if showCancelButton {
            // Add dismiss button
            let dismissButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(FileListViewController.dismiss(button:)))
            self.navigationItem.rightBarButtonItem = dismissButton
        }
    }
    
    deinit{
        if #available(iOS 9.0, *) {
            searchController.loadViewIfNeeded()
        } else {
            searchController.loadView()
        }
    }
    
    func prepareData() {
        // Prepare data
        if let initialPath = initialPath {
            files = parser.filesForDirectory(initialPath)
            indexFiles()
        }
    }
    
    //MARK: UIViewController
    
    override func viewDidLoad() {
        
        prepareData()
        
        // Set search bar
        tableView.tableHeaderView = searchController.searchBar
        
        // Register for 3D touch
        self.registerFor3DTouch()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Scroll to hide search bar
        self.tableView.contentOffset = CGPoint(x: 0, y: searchController.searchBar.frame.size.height)
        
        // Make sure navigation bar is visible
        self.navigationController?.isNavigationBarHidden = false
    }
    
    @objc func dismiss(button: UIBarButtonItem = UIBarButtonItem()) {
        self.dismiss(animated: true, completion: {
            self.didClose?()
        })
    }
    
    //MARK: Data
    
    func indexFiles() {
        let selector: Selector = #selector(getter: FBFile.displayName)
        sections = Array(repeating: [], count: collation.sectionTitles.count)
        if let sortedObjects = collation.sortedArray(from: files, collationStringSelector: selector) as? [FBFile]{
            for object in sortedObjects {
                let sectionNumber = collation.section(for: object, collationStringSelector: selector)
                sections[sectionNumber].append(object)
            }
        }
    }
    
    func fileForIndexPath(_ indexPath: IndexPath) -> FBFile {
        var file: FBFile
        if searchController.isActive {
            file = filteredFiles[(indexPath as NSIndexPath).row]
        }
        else {
            file = sections[(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row]
        }
        return file
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredFiles = files.filter({ (file: FBFile) -> Bool in
            return file.displayName.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }

}

