//
//  RecordTableViewCell.swift
//  Pods
//
//  Created by zixun on 16/12/28.
//
//

import Foundation

class RecordTableViewCell: UITableViewCell {
    

    static let reuseIdentifier = NSStringFromClass(RecordTableViewCell.classForCoder())
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.clear
        self.selectionStyle = .none
        
        self.addSubview(self.logTextView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ attributedText: NSAttributedString) {
        self.logTextView.attributedText = attributedText
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var rect = self.bounds
        rect.origin.x = 5
        rect.size.width -= 10
        self.logTextView.frame = rect
    }
    
//        private lazy var logLabel: UILabel = {
//            let new = UILabel()
//            new.numberOfLines = 0
//            new.font = Define.Font.log
//            new.textColor = self.configurator.skin.textBodyColor
//            new.backgroundColor = UIColor.clear
//            return new
//        }()
    
    private lazy var logTextView: UITextView = { [unowned self] in
        let new = UITextView()
        new.isSelectable = false
        new.isEditable = false
        new.isScrollEnabled = false
        new.textContainer.lineFragmentPadding = 0
        new.textContainerInset = UIEdgeInsets.zero
        new.textAlignment = .left
        new.clipsToBounds = true
        new.font = UIFont.courier(with: 12)
        new.textColor = UIColor.white
        new.backgroundColor = UIColor.clear
        new.isUserInteractionEnabled = false
        return new
        }()
}


extension RecordTableViewCell {
    
    class func boundingHeight(with width:CGFloat,
                              attributedText:NSAttributedString) -> CGFloat {
        let size = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let rect = attributedText.boundingRect(with: size, options: [.usesLineFragmentOrigin, .usesDeviceMetrics, .usesFontLeading,.truncatesLastVisibleLine], context: nil)
        return max(rect.size.height, 10.5)
    }
}
