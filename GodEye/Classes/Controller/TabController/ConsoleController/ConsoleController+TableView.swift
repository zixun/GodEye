//
//  ConsoleViewController+TableView.swift
//  Pods
//
//  Created by zixun on 16/12/28.
//
//

import Foundation

class ConsoleTableViewModel: NSObject {
    private(set) var title: String!
    
    private(set) var detail: String!
    
    init(title:String, detail:String) {
        super.init()
        self.title = title
        self.detail = detail
    }
    
}

extension ConsoleController {
    func reloadRow(of type:RecordType) {
        if let indexPath = self.indexPath(of: type) {
            self.tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.none)
        }
    }
    
    private func indexPath(of type:RecordType) -> IndexPath? {
        for i in 0..<self.dataSource.count {
            let types = self.dataSource[i]
            for j in 0..<types.count {
                
                if self.dataSource[i][j] == type {
                    return IndexPath(row: j, section: i)
                }
            }
        }
        return nil
    }
}

extension ConsoleController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let type = self.dataSource[indexPath.section][indexPath.row]
        let cp = ConsolePrintViewController(type: type)
        self.navigationController?.pushViewController(cp, animated: true)
        self.printViewController = cp
        type.cleanUnread()
        self.reloadRow(of: type)
    }
}

extension ConsoleController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return tableView.dequeueReusableCell(style: UITableViewCellStyle.subtitle,
                                             identifier: ConsoleTableViewCell.identifier(), { (cell:ConsoleTableViewCell) in
                                                
        })
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = cell as! ConsoleTableViewCell
        cell.configure(type: self.dataSource[indexPath.section][indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "RECORD"
        case 1:
            return "Terminal"
        default:
            return ""
        }
    }
}

class ConsoleTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clear
        self.textLabel?.textColor = UIColor.white
        self.detailTextLabel?.textColor = UIColor.gray
        self.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        
        self.contentView.addSubview(self.unreadLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(type:RecordType)  {
        self.textLabel?.text = type.title()
        self.detailTextLabel?.text = type.detail()
        
        let unread = type.unread()
        if unread == 0 {
            self.unreadLabel.text = nil
        }else if unread >= 100 {
            self.unreadLabel.text = "99+"
        }else {
            self.unreadLabel.text = String.init(unread)
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let text = self.unreadLabel.attributedText {
            var size = CGSize(width: CGFloat.greatestFiniteMagnitude, height: self.unreadLabel.layer.cornerRadius * 2 )
            size = text.boundingRect(with: size, options: .usesLineFragmentOrigin, context: nil).size
            size.width += 18
            size.height = self.unreadLabel.layer.cornerRadius * 2
            var rect = CGRect.zero
            rect.size = size
            rect.origin.x = self.frame.size.width - 30 - size.width
            rect.origin.y = (self.frame.size.height - size.height) / 2.0
            self.unreadLabel.frame = rect
        }else {
            self.unreadLabel.frame = CGRect.zero
        }
    }
    
    private lazy var unreadLabel: UILabel = {
        let new = UILabel()
        new.layer.masksToBounds = true
        new.layer.cornerRadius = 10
        new.textAlignment = .center
        new.font = UIFont.systemFont(ofSize: 12)
        new.text = nil
        new.textColor = UIColor.white
        new.backgroundColor = UIColor.red
        return new
    }()
}
