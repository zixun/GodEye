//
//  FileController.swift
//  Pods
//
//  Created by zixun on 17/1/10.
//
//

import Foundation
import FileBrowser

class FileController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.niceBlack()
        
        self.view.addSubview(self.tableView)
    }
    
    private lazy var tableView: UITableView = { [unowned self] in
        let new = UITableView(frame: CGRect.zero, style: .grouped)
        new.delegate = self
        new.dataSource = self
        new.backgroundColor = UIColor.clear
        return new
    }()
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.tableView.frame = self.view.bounds
    }
}

extension FileController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return tableView.dequeueReusableCell(style: UITableViewCellStyle.subtitle, identifier: UITableViewCell.identifier(), { (cell:UITableViewCell) in
            cell.backgroundColor = UIColor.clear
            cell.textLabel?.textColor = UIColor.white
            cell.detailTextLabel?.textColor = UIColor.gray
            cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        })
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            cell.detailTextLabel?.text = "document, cache, etc..."
            cell.textLabel?.text = "App Home Folder"
        }else if indexPath.row == 1 {
            let path = Bundle.main.bundlePath
            cell.detailTextLabel?.text = "all file and folder in \(path.NS.lastPathComponent)"
            cell.textLabel?.text = path.NS.lastPathComponent + " Folder"
        }else if indexPath.row == 2 {
            cell.detailTextLabel?.text = "all file and folder in /"
            cell.textLabel?.text = "Root Folder"
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var url: URL?
        if indexPath.row == 0 {
            let str = NSSearchPathForDirectoriesInDomains(.applicationDirectory,
                                                          .userDomainMask,
                                                          true).first!.NS.deletingLastPathComponent
            url = URL(string: str)
        }else if indexPath.row == 1 {
            url = URL(string: Bundle.main.bundlePath)
        }else if indexPath.row == 2 {
            url = URL(string:"/")
        }
        
        if let url = url {
            let browser = FileBrowser(initialPath: url)
            self.present(browser, animated: true, completion: nil)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Folder"
        default:
            return ""
        }
    }
}

