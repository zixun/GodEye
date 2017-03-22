//
//  ViewController.swift
//  ESPullToRefreshExample
//
//  Created by egg swift on 16/5/5.
//  Copyright © 2016年 egg swift. All rights reserved.
//

import UIKit

public enum ESRefreshExampleType {
    case defaulttype, meituan, wechat
}

public enum ESRefreshExampleListType {
    case tableview, collectionview
}

public class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    public var listType: ESRefreshExampleListType = .tableview
    
    public let dataArray = [
        "Default",
        "美团网 (Meituan.com)",
        "WeChat",
        "TextView",
        "Day",
        "CollectionView"
        ]
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        let appearance = UIBarButtonItem.appearance()
        appearance.setBackButtonTitlePositionAdjustment(UIOffset.init(horizontal: 0.0, vertical: -60), for: .default)

        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 250/255.0, green: 250/255.0, blue: 250/255.0, alpha: 0.8)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.init(red: 38/255.0, green: 38/255.0, blue: 38/255.0, alpha: 1.0), NSFontAttributeName: UIFont.systemFont(ofSize: 16.0)]
        self.navigationController?.navigationBar.tintColor = UIColor.init(red: 38/255.0, green: 38/255.0, blue: 38/255.0, alpha: 1.0)
        self.navigationItem.title = "Example"
        
        self.tableView.register(UINib.init(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "ListTableViewCell")
    }
    
    public func select(indexPath: IndexPath) {
        var vc: UIViewController!
        switch indexPath.row {
        case 0:
            vc = ESRefreshTableViewController.init(style: .plain)
            if let vc = vc as? ESRefreshTableViewController {
                vc.type = .defaulttype
            }
        case 1:
            vc = ESRefreshTableViewController.init(style: .plain)
            if let vc = vc as? ESRefreshTableViewController {
                vc.type = .meituan
            }
        case 2:
            vc = ESRefreshTableViewController.init(style: .plain)
            if let vc = vc as? ESRefreshTableViewController {
                vc.type = .wechat
            }
        case 3:
            vc = TextViewController.init()
        case 4:
            vc = ESRefreshTableViewController.init(style: .plain)
        case 5:
            vc = CollectionViewController()
        default:
            break
        }
        vc.title = dataArray[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: UITableViewDataSource
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54.0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell")
        if let cell = cell as? ListTableViewCell {
            cell.titleLabel.text = "\(indexPath.row + 1).   " + dataArray[indexPath.row]
        }
        return cell!
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.5
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.bounds.size.width, height: 0.5))
        view.backgroundColor = UIColor.lightGray
        return view
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        self.select(indexPath: indexPath)
    }
    
}
