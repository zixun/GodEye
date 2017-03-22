//
//  WeChatTableViewController.swift
//  ESPullToRefreshExample
//
//  Created by lihao on 16/5/9.
//  Copyright © 2016年 egg swift. All rights reserved.
//

import UIKit

class WeChatTableViewController: UITableViewController {
    var array = [String]()
    var page = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.backgroundColor = UIColor.init(red: 46/255.0, green: 49/255.0, blue: 50/255.0, alpha: 1.0)
        self.tableView.register(UINib.init(nibName: "DefaultTableViewCell", bundle: nil), forCellReuseIdentifier: "DefaultTableViewCell")
        
        // Header like WeChat
        let header = WeChatTableHeaderView.init(frame: CGRect.init(origin: CGPoint.zero, size: CGSize.init(width: self.view.bounds.size.width, height: 260)))
        self.tableView.tableHeaderView = header
        
        /// Add some data
        for _ in 1...8{
            self.array.append(" ")
        }
        
        let _ = self.tableView.es_addPullToRefresh(animator: WCRefreshHeaderAnimator.init(frame: CGRect.zero)) {
            [weak self] in
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self?.page = 1
                self?.array.removeAll()
                for _ in 1...8{
                    self?.array.append(" ")
                }
                self?.tableView.reloadData()
                self?.tableView.es_stopPullToRefresh(completion: true)
            }
        }
        self.tableView.refreshIdentifier = NSStringFromClass(DefaultTableViewController.self) // Set refresh identifier
        self.tableView.expriedTimeInterval = 20.0 // 20 second alive.
        
        let _ = self.tableView.es_addInfiniteScrolling() {
            [weak self] in
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self?.page += 1
                if self?.page ?? 0 <= 3 {
                    for _ in 1...8{
                        self?.array.append(" ")
                    }
                    self?.tableView.reloadData()
                    self?.tableView.es_stopLoadingMore()
                } else {
                    self?.tableView.es_noticeNoMoreData()
                }
            }
        }
        self.tableView.es_footer?.backgroundColor = UIColor.white // Custom footer background color
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.es_autoPullToRefresh()
    }
    
    // MARK: - Table view data source
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultTableViewCell", for: indexPath as IndexPath)
        cell.backgroundColor = UIColor.init(white: 250.0 / 255.0, alpha: 1.0)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        let vc = WebViewController.init()
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
