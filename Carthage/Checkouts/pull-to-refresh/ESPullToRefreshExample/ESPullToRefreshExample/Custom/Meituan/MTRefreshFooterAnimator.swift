//
//  MTRefreshFooterAnimator.swift
//  ESPullToRefreshExample
//
//  Created by lihao on 16/5/7.
//  Copyright © 2016年 egg swift. All rights reserved.
//

import UIKit

public class MTRefreshFooterAnimator: UIView, ESRefreshProtocol, ESRefreshAnimatorProtocol {
    public let loadingMoreDescription: String = "Loading more"
    public let noMoreDataDescription: String  = "No more data"
    public let loadingDescription: String     = "Loading..."
    
    public var view: UIView {
        return self
    }
    public var insets: UIEdgeInsets = UIEdgeInsets.zero
    public var trigger: CGFloat = 48.0
    public var executeIncremental: CGFloat = 48.0
    public var state: ESRefreshViewState = .pullToRefresh
    
    private let topLine: UIView = {
        let topLine = UIView.init(frame: CGRect.zero)
        topLine.backgroundColor = UIColor.init(red: 214/255.0, green: 211/255.0, blue: 206/255.0, alpha: 1.0)
        return topLine
    }()
    private let bottomLine: UIView = {
        let bottomLine = UIView.init(frame: CGRect.zero)
        bottomLine.backgroundColor = UIColor.init(red: 214/255.0, green: 211/255.0, blue: 206/255.0, alpha: 1.0)
        return bottomLine
    }()
    private let titleLabel: UILabel = {
        let label = UILabel.init(frame: CGRect.zero)
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textColor = UIColor.init(white: 160.0 / 255.0, alpha: 1.0)
        label.textAlignment = .center
        return label
    }()
    private let indicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView.init(activityIndicatorStyle: .gray)
        indicatorView.isHidden = true
        return indicatorView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        titleLabel.text = loadingMoreDescription
        addSubview(titleLabel)
        addSubview(indicatorView)
        addSubview(topLine)
        addSubview(bottomLine)
    }
    
    public required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func refreshAnimationBegin(view: ESRefreshComponent) {
        indicatorView.startAnimating()
        indicatorView.isHidden = false
    }
    
    public func refreshAnimationEnd(view: ESRefreshComponent) {
        indicatorView.stopAnimating()
        indicatorView.isHidden = true
    }
    
    public func refresh(view: ESRefreshComponent, progressDidChange progress: CGFloat) {
        // do nothing
    }
    
    public func refresh(view: ESRefreshComponent, stateDidChange state: ESRefreshViewState) {
        switch state {
        case .refreshing :
            titleLabel.text = loadingDescription
            break
        case .autoRefreshing :
            titleLabel.text = loadingDescription
            break
        case .noMoreData:
            titleLabel.text = noMoreDataDescription
            break
        default:
            titleLabel.text = loadingMoreDescription
            break
        }
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        let s = self.bounds.size
        let w = s.width
        let h = s.height
        titleLabel.frame = self.bounds
        indicatorView.center = CGPoint.init(x: 32.0, y: h / 2.0)
        topLine.frame = CGRect.init(x: 0.0, y: 0.0, width: w, height: 0.5)
        bottomLine.frame = CGRect.init(x: 0.0, y: h - 1.0, width: w, height: 1.0)
    }
}
