//
//  STTableViewDemoController.swift
//  STViewCapture
//
//  Created by chenxing.cx on 15/10/28.
//  Copyright © 2015年 startry.com All rights reserved.
//

import UIKit

class STTableViewDemoController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let cellIdentify = "resuseableCellIdentify"
    
    var tableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Capture", style: UIBarButtonItemStyle.plain, target: self, action: #selector(STTableViewDemoController.didCaptureBtnClicked(_:)))
        
        tableView = UITableView() // tableView
        
        tableView?.dataSource = self
        tableView?.delegate   = self
        
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentify)
        
        view.addSubview(tableView!)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView?.frame = view.bounds
    }
    
    // MARK: TableView DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentify)
        
        cell?.textLabel?.text = "show cell \((indexPath as NSIndexPath).row)"
        
        return cell!
    }
    
    // MARK : Events
    func didCaptureBtnClicked(_ button: UIButton){
        
        tableView?.swContentCapture({ (capturedImage) -> Void in
            let vc = ImageViewController(image: capturedImage!)
            self.navigationController?.pushViewController(vc, animated: true)
        })
        
//        tableView?.swContentScrollCapture({ (capturedImage) -> Void in
//            let vc = ImageViewController(image: capturedImage!)
//            self.navigationController?.pushViewController(vc, animated: true)
//        })
    }
    
}
