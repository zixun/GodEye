//
//  MonitorDeviceView.swift
//  Pods
//
//  Created by zixun on 17/1/5.
//
//

import Foundation

class MonitorDeviceView: UIButton {
    
    init() {
        super.init(frame: CGRect.zero)
        self.backgroundColor = UIColor.clear
        self.addSubview(self.nameLabel)
        self.addSubview(self.osLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(nameString:String,osString:String) {
        self.nameLabel.text = nameString
        self.osLabel.text = "OS Version: \(osString)"
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let left : CGFloat = 20.0;
        let boundingSize = CGSize(width: self.frame.size.width - left, height: CGFloat.greatestFiniteMagnitude)
        
        if let text = self.osLabel.attributedText {
            let size = text.boundingRect(with: boundingSize, options: .usesLineFragmentOrigin, context: nil).size
            self.osLabel.frame = CGRect(origin: CGPoint(x: left, y: self.frame.size.height - 10 - size.height), size: size)
        }
        
        if let text = self.nameLabel.attributedText {
            let size = text.boundingRect(with: boundingSize, options: .usesLineFragmentOrigin, context: nil).size
            self.nameLabel.frame = CGRect(origin: CGPoint(x: left, y: self.osLabel.frame.minY - 10 - size.height), size: size)
        }
    }
    
    private lazy var nameLabel: UILabel = {
        let new = UILabel()
        new.font = UIFont.boldSystemFont(ofSize: 24)
        new.textColor = UIColor.white
        new.textAlignment = .left
        return new
    }()
    
    private lazy var osLabel: UILabel = {
        let new = UILabel()
        new.font = UIFont.systemFont(ofSize: 18)
        new.textColor = UIColor.white
        new.textAlignment = .left
        return new
    }()
}
