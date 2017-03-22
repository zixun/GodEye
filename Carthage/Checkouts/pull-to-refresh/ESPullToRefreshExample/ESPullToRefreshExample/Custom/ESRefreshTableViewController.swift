//
//  ESRefreshTableViewController.swift
//  ESPullToRefreshExample
//
//  Created by lihao on 16/8/18.
//  Copyright © 2016年 egg swift. All rights reserved.
//

import UIKit

public class ESRefreshTableViewController: UITableViewController {

    public var array = [String]()
    public var page = 1
    public var type: ESRefreshExampleType = .defaulttype
    
    public override init(style: UITableViewStyle) {
        super.init(style: style)
        for num in 1...8{
            if num % 2 == 0 && arc4random() % 4 == 0 {
                self.array.append("info")
            } else {
                self.array.append("photo")
            }
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.backgroundColor = UIColor.init(red: 244.0 / 255.0, green: 245.0 / 255.0, blue: 245.0 / 255.0, alpha: 1.0)
        
        self.tableView.register(UINib.init(nibName: "ESRefreshTableViewCell", bundle: nil), forCellReuseIdentifier: "ESRefreshTableViewCell")
        self.tableView.register(UINib.init(nibName: "ESPhotoTableViewCell", bundle: nil), forCellReuseIdentifier: "ESPhotoTableViewCell")
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 560
        self.tableView.separatorStyle = .none
        self.tableView.separatorColor = UIColor.clear
        
        var header: ESRefreshProtocol & ESRefreshAnimatorProtocol
        var footer: ESRefreshProtocol & ESRefreshAnimatorProtocol
        switch type {
        case .meituan:
            header = MTRefreshHeaderAnimator.init(frame: CGRect.zero)
            footer = MTRefreshFooterAnimator.init(frame: CGRect.zero)
        case .wechat:
            header = WCRefreshHeaderAnimator.init(frame: CGRect.zero)
            footer = ESRefreshFooterAnimator.init(frame: CGRect.zero)
        default:
            header = ESRefreshHeaderAnimator.init(frame: CGRect.zero)
            footer = ESRefreshFooterAnimator.init(frame: CGRect.zero)
            break
        }
        
        self.tableView.es_addPullToRefresh(animator: header) { [weak self] in
            self?.refresh()
        }
        self.tableView.es_addInfiniteScrolling(animator: footer) { [weak self] in
            self?.loadMore()
        }
        self.tableView.refreshIdentifier = String.init(describing: type)
        self.tableView.expriedTimeInterval = 20.0
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.tableView.es_autoPullToRefresh()
        }
    }

    private func refresh() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.page = 1
            self.array.removeAll()
            for num in 1...8{
                if num % 2 == 0 && arc4random() % 4 == 0 {
                    self.array.append("info")
                } else {
                    self.array.append("photo")
                }
            }
            self.tableView.reloadData()
            self.tableView.es_stopPullToRefresh()
        }
    }
    
    private func loadMore() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.page += 1
            if self.page <= 3 {
                for num in 1...8{
                    if num % 2 == 0 && arc4random() % 4 == 0 {
                        self.array.append("info")
                    } else {
                        self.array.append("photo")
                    }
                }
                self.tableView.reloadData()
                self.tableView.es_stopLoadingMore()
            } else {
                self.tableView.es_noticeNoMoreData()
            }
        }
    }
    
    // MARK: - Table view data source
    public override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }

    public override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        let string = self.array[indexPath.row]
        if string == "info" {
            cell = tableView.dequeueReusableCell(withIdentifier: "ESRefreshTableViewCell", for: indexPath as IndexPath)
        } else if string == "photo" {
            cell = tableView.dequeueReusableCell(withIdentifier: "ESPhotoTableViewCell", for: indexPath as IndexPath)
            if let cell = cell as? ESPhotoTableViewCell {
                cell.updateContent(indexPath: indexPath)
            }
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath as IndexPath)
        }
        return cell
    }
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        self.navigationController?.pushViewController(WebViewController.init(), animated: true)
    }
    
}
