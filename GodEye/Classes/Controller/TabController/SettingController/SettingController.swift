//
//  SettingController.swift
//  Pods
//
//  Created by zixun on 17/1/10.
//
//

import Foundation

class SettingController: UIViewController {
    
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

extension SettingController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return tableView.dequeueReusableCell(style: UITableViewCellStyle.subtitle, identifier: UITableViewCell.identifier(), { (cell:UITableViewCell) in
            cell.backgroundColor = UIColor.clear
            cell.textLabel?.textColor = UIColor.white
            cell.detailTextLabel?.textColor = UIColor.gray
            let accessoryView = UISwitch()
            accessoryView.isOn = false
            accessoryView.addTarget(self, action: #selector(SettingController.switchValueChanged(sender:)), for: .valueChanged)
            cell.accessoryView = accessoryView
        })
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let accessoryView: UISwitch = cell.accessoryView as! UISwitch
        accessoryView.tag = indexPath.row
        
        if indexPath.row == 0 {
            cell.detailTextLabel?.text = "eye of Apple System Logs"
            cell.textLabel?.text = "ASL Eye Switch"
            accessoryView.isOn = EyesManager.shared.isASLEyeOpening()
        }else if indexPath.row == 1 {
            cell.detailTextLabel?.text = "monitor of log4g"
            cell.textLabel?.text = "Log4G Switch"
            accessoryView.isOn = EyesManager.shared.isLog4GEyeOpening()
        }else if indexPath.row == 2 {
            cell.detailTextLabel?.text = "eye of crash stack information"
            cell.textLabel?.text = "Crash Eye Switch"
            accessoryView.isOn = EyesManager.shared.isCrashEyeOpening()
        }else if indexPath.row == 3 {
            cell.detailTextLabel?.text = "eye of network request and response"
            cell.textLabel?.text = "Network Eye Switch"
            accessoryView.isOn = EyesManager.shared.isNetworkEyeOpening()
        }else if indexPath.row == 4 {
            cell.detailTextLabel?.text = "eye of application not responding"
            cell.textLabel?.text = "ANR Eye Switch"
            accessoryView.isOn = EyesManager.shared.isANREyeOpening()
        }else if indexPath.row == 5 {
            cell.detailTextLabel?.text = "eye of object leak"
            cell.textLabel?.text = "Leak Eye Switch"
            accessoryView.isOn = EyesManager.shared.isLeakEyeOpening()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Switch"
        default:
            return ""
        }
    }
    
    @objc private func switchValueChanged(sender:UISwitch) {
        let index = sender.tag
        if index == 0 {
            let manager = EyesManager.shared
            sender.isOn == true ? manager.openASLEye() : manager.closeASLEye()
            UIAlertView(title: "INFO",
                        message: "ASL Eye will case a bit of cpu usage.\nif you are collecting the cpu usage, please turn it off",
                        delegate: nil,
                        cancelButtonTitle: "OK").show()
        }else if index == 1 {
            let manager = EyesManager.shared
            sender.isOn == true ? manager.openLog4GEye() : manager.closeLog4GEye()
        }else if index == 2 {
            let manager = EyesManager.shared
            sender.isOn == true ? manager.openCrashEye() : manager.closeCrashEye()
        }else if index == 3 {
            let manager = EyesManager.shared
            sender.isOn == true ? manager.openNetworkEye() : manager.closeNetworkEye()
        }else if index == 4 {
            let manager = EyesManager.shared
            sender.isOn == true ? manager.openANREye() : manager.closeANREye()
        }else if index == 5 {
            let manager = EyesManager.shared
            sender.isOn == true ? manager.openLeakEye() : manager.closeLeakEye()
        }
    }
}

