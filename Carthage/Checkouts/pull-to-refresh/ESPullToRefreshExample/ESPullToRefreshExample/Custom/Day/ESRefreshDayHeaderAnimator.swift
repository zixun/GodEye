//
//  ESRefreshDayHeaderAnimator.swift
//  ESPullToRefreshExample
//
//  Created by lihao on 16/7/18.
//  Copyright © 2016年 egg swift. All rights reserved.
//

import UIKit

public class ESRefreshDayHeaderAnimator: UIView, ESRefreshProtocol, ESRefreshAnimatorProtocol {
    public var insets: UIEdgeInsets = UIEdgeInsets.zero
    public var view: UIView { return self }
    public var trigger: CGFloat = 120.0
    public var executeIncremental: CGFloat = 120.0
    public var state: ESRefreshViewState = .pullToRefresh
    
    private var percent: CGFloat = 0
    private var isDay: Bool = true {
        didSet {
            self.dayImageView.isHidden = !isDay
            self.nightImageView.isHidden = isDay
        }
    }
    private lazy var timer: Timer! = {
        let timer = Timer.scheduledTimer(timeInterval: 0.002, target: self, selector: #selector(ESRefreshDayHeaderAnimator.timerAction), userInfo: nil, repeats: true)
        return timer
    }()
    
    private let backImageView: UIImageView = {
        let imageView = UIImageView.init()
        imageView.image = UIImage.init(named: "icon_pull_to_refresh_back")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    private let dayImageView: UIImageView = {
        let imageView = UIImageView.init()
        imageView.image = UIImage.init(named: "icon_pull_to_refresh_day")
        imageView.sizeToFit()
        return imageView
    }()
    private let nightImageView: UIImageView = {
        let imageView = UIImageView.init()
        imageView.image = UIImage.init(named: "icon_pull_to_refresh_night")
        imageView.sizeToFit()
        imageView.isHidden = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(backImageView)
        self.addSubview(dayImageView)
        self.addSubview(nightImageView)
    }
    
    public required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func refreshAnimationBegin(view: ESRefreshComponent) {
        self.timer.fire()
        percent = 0.5
    }

    public func refreshAnimationEnd(view: ESRefreshComponent) {
        self.timer.invalidate()
        self.timer = nil
        isDay = true
        percent = 0.5
    }
    
    public func refresh(view: ESRefreshComponent, progressDidChange progress: CGFloat) {
        let buttom: CGFloat = 2.0
        let top: CGFloat = 12.0
        let p = min(1.0, max(0.0, progress))
        let w = self.bounds.size.width
        let h = self.bounds.size.height
        let size = dayImageView.image?.size ?? CGSize.zero
        self.dayImageView.center = CGPoint.init(x: w / 2.0, y: (h - buttom - size.height / 2.0) - (h - top - buttom - size.height) * p)
    }
    
    public func refresh(view: ESRefreshComponent, stateDidChange state: ESRefreshViewState) {
        
    }
    
    public func timerAction() {
        percent += 0.001
        if percent >= 1.0 {
            percent = 0.0
            isDay = !isDay
        }
        self.animateAction()
    }
    
    public func animateAction() {
        let p = percent < 0.25 ? percent * 2 : percent > 0.75 ? (0.5 + (percent - 0.75) * 2) : 0.5
        
        let top: CGFloat = 12.0
        let buttom: CGFloat = 16.0
        let size = dayImageView.image?.size ?? CGSize.zero
        let w = self.bounds.size.width
        let h = self.bounds.size.height
        let x = p * w
        let y = top + (size.height / 2.0) + (h - top - buttom - size.height) * (1 - CGFloat(sin(CGFloat(M_PI) * p)))
        if isDay {
            let colorP = p < 0.5 ? (0.5 + p) : (p == 0.5 ? 1.0 : (0.5 + 1.0 - p))
            self.backgroundColor = UIColor.init(white: colorP, alpha: 1.0)
            self.dayImageView.center = CGPoint.init(x: x, y: y)
        } else {
            let colorP = p < 0.5 ? (0.5 - p) : (p == 0.5 ? 0.0 : (p - 0.5))
            self.backgroundColor = UIColor.init(white: colorP, alpha: 1.0)
            self.nightImageView.center = CGPoint.init(x: x, y: y)
        }
    }
    
}
