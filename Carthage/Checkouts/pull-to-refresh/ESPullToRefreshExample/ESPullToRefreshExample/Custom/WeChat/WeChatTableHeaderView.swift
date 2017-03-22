//
//  WeChatTableHeaderView.swift
//  ESPullToRefreshExample
//
//  Created by lihao on 16/5/9.
//  Copyright © 2016年 egg swift. All rights reserved.
//

import UIKit

class WeChatTableHeaderView: UIView {
    let imageView: UIImageView = {
        let imageView = UIImageView.init(image: UIImage.init(named: "icon_wechat_header"))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let avatarView: UIImageView = {
        let avatarView = UIImageView.init(image: UIImage.init(named: "icon"))
        return avatarView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(imageView)
        self.addSubview(avatarView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = self.bounds
        avatarView.frame = CGRect.init(x: self.bounds.size.width - 10.0 - 75.0, y: self.bounds.size.height - 48.0, width: 75.0, height: 75.0)
    }
    
}
