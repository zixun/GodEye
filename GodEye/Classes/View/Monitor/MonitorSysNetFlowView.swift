//
//  MonitorSysNetFlowView.swift
//  Pods
//
//  Created by zixun on 17/1/6.
//
//

import Foundation
import SystemEye

class MonitorSysNetFlowView: UIButton {
    
    private(set) var type: MonitorSystemType!
    
    init(type:MonitorSystemType) {
        super.init(frame: CGRect.zero)
        self.type = type
        self.infoLabel.text = type.info
        self.addSubview(self.topLine)
        self.addSubview(self.infoLabel)
        self.addSubview(self.wifiSendLabel)
        self.addSubview(self.wifiReceivedLabel)
        self.addSubview(self.wwanSendLabel)
        self.addSubview(self.wwanReceivedLabel)
        
    }
    
    func configure(wifiSend:UInt32,wifiReceived:UInt32,wwanSend:UInt32,wwanReceived:UInt32) {
        
        self.wifiSendLabel.attributedText = self.attributedString(prefix: "wifi send:", byte: wifiSend)
        self.wifiReceivedLabel.attributedText = self.attributedString(prefix: "wifi received:", byte: wifiReceived)
        self.wwanSendLabel.attributedText = self.attributedString(prefix: "wwan send:", byte: wwanSend)
        self.wwanReceivedLabel.attributedText = self.attributedString(prefix: "wwan received:", byte: wwanReceived)
    }
    
    private func attributedString(prefix:String,byte:UInt32) -> NSAttributedString {
        let result = NSMutableAttributedString()
        let storage = Double(byte).storageCapacity()
        
        result.append(NSAttributedString(string: prefix + "  ",
                                         attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 10),
                                                      NSAttributedStringKey.foregroundColor:UIColor.white]))
        result.append(NSAttributedString(string: String.init(format: "%.1f",storage.capacity),
                                         attributes: [NSAttributedStringKey.font:UIFont(name: "HelveticaNeue-UltraLight", size: 18),
                                                      NSAttributedStringKey.foregroundColor:UIColor.white]))
        result.append(NSAttributedString(string: storage.unit,
                                         attributes: [NSAttributedStringKey.font:UIFont(name: "HelveticaNeue-UltraLight", size: 12),
                                                      NSAttributedStringKey.foregroundColor:UIColor.white]))
        return result
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var rect = CGRect.zero
        rect.origin.x = 20
        rect.origin.y = 10
        rect.size.width = self.frame.size.width - 20
        rect.size.height = 12
        self.infoLabel.frame = rect
        
        rect.origin.x = 20
        rect.origin.y = 0
        rect.size.width = self.frame.size.width - rect.origin.x * 2.0
        rect.size.height = 0.5
        self.topLine.frame = rect
        
        
        rect = CGRect(x: 30, y: self.infoLabel.frame.maxY + 5, width: self.frame.size.width / 2.0 , height: 21)
        self.wifiSendLabel.frame = rect
        
        rect.origin.y = rect.maxY + 5
        self.wifiReceivedLabel.frame = rect
        
        rect.origin.x = self.frame.size.width / 2.0 + 30
        self.wwanReceivedLabel.frame = rect
        
        rect.origin.y = rect.minY - 5 - rect.size.height
        self.wwanSendLabel.frame = rect
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private(set) lazy var infoLabel: UILabel = {
        let new = UILabel()
        new.font = UIFont.systemFont(ofSize: 12)
        new.textColor = UIColor.white
        return new
    }()
    
    private(set) lazy var wifiSendLabel: UILabel = {
        let new = UILabel()
        new.font = UIFont.systemFont(ofSize: 12)
        new.textColor = UIColor.white
        return new
    }()
    
    private(set) lazy var wifiReceivedLabel: UILabel = {
        let new = UILabel()
        new.font = UIFont.systemFont(ofSize: 12)
        new.textColor = UIColor.white
        return new
    }()
    
    private(set) lazy var wwanSendLabel: UILabel = {
        let new = UILabel()
        new.font = UIFont.systemFont(ofSize: 12)
        new.textColor = UIColor.white
        return new
    }()
    
    private(set) lazy var wwanReceivedLabel: UILabel = {
        let new = UILabel()
        new.font = UIFont.systemFont(ofSize: 12)
        new.textColor = UIColor.white
        return new
    }()
    
    private lazy var topLine: UIView = {
        let new = UIView()
        new.backgroundColor = UIColor.white
        return new
    }()
    
}
