//
//  ESRefreshDayTableViewController.swift
//  ESPullToRefreshExample
//
//  Created by lihao on 16/7/18.
//  Copyright © 2016年 egg swift. All rights reserved.
//

import UIKit

public class ESRefreshDayTableViewController: UITableViewController {
    var array = [String]()
    var page = 1
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.backgroundColor = UIColor.init(red: 240/255.0, green: 239/255.0, blue: 237/255.0, alpha: 1.0)
        self.tableView.register(UINib.init(nibName: "DefaultTableViewCell", bundle: nil), forCellReuseIdentifier: "DefaultTableViewCell")
        
        for _ in 1...8{
            self.array.append(" ")
        }
        
        self.tableView.es_addPullToRefresh(animator: ESRefreshDayHeaderAnimator.init(frame: CGRect.zero)) {
            [weak self] in
            let minseconds = 3.0 * Double(NSEC_PER_SEC)
            let dtime = DispatchTime.now(dispatch_time_t(DispatchTime.now), Int64(minseconds))
            dispatch_after(dtime, DispatchQueue.main , {
                self?.page = 1
                self?.array.removeAll()
                for _ in 1...8{
                    self?.array.append(" ")
                }
                self?.tableView.reloadData()
                self?.tableView.es_stopPullToRefresh(completion: true)
            })
        }
        self.tableView.refreshIdentifier = NSStringFromClass(DefaultTableViewController) // Set refresh identifier
        self.tableView.expriedTimeInterval = 20.0 // 20 second alive.
        
        self.tableView.es_addInfiniteScrolling(animator: MTRefreshFooterAnimator.init(frame: CGRect.zero)) {
            [weak self] in
            let minseconds = 3.0 * Double(NSEC_PER_SEC)
            let dtime = DispatchTime.now(dispatch_time_t(DispatchTime.now), Int64(minseconds))
            dispatch_after(dtime, DispatchQueue.main , {
                self?.page += 1
                if self?.page <= 3 {
                    for _ in 1...8{
                        self?.array.append(" ")
                    }
                    self?.tableView.reloadData()
                    self?.tableView.es_stopLoadingMore()
                } else {
                    self?.tableView.es_noticeNoMoreData()
                }
            })
        }
    }
    
    override public func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.es_autoPullToRefresh()
    }
    
    // MARK: - Table view data source
    override public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    override public func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100.0
    }
    
    override public func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    override public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultTableViewCell", for: indexPath as IndexPath)
        cell.backgroundColor = UIColor.init(white: 250.0 / 255.0, alpha: 1.0)
        return cell
    }
    
    override public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        let vc = WebViewController.init()
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
