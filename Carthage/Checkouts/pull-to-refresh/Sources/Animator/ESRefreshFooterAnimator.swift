//
//  ESRefreshFooterAnimator.swift
//
//  Created by egg swift on 16/4/7.
//  Copyright (c) 2013-2016 ESPullToRefresh (https://github.com/eggswift/pull-to-refresh)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import UIKit

open class ESRefreshFooterAnimator: UIView, ESRefreshProtocol, ESRefreshAnimatorProtocol {

    open var loadingMoreDescription: String = "Loading more"
    open var noMoreDataDescription: String  = "No more data"
    open var loadingDescription: String     = "Loading..."

    open var view: UIView { return self }
    open var duration: TimeInterval = 0.3
    open var insets: UIEdgeInsets = UIEdgeInsets.zero
    open var trigger: CGFloat = 42.0
    open var executeIncremental: CGFloat = 42.0
    open var state: ESRefreshViewState = .pullToRefresh
    
    fileprivate let titleLabel: UILabel = {
        let label = UILabel.init(frame: CGRect.zero)
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textColor = UIColor.init(white: 160.0 / 255.0, alpha: 1.0)
        label.textAlignment = .center
        return label
    }()
    
    fileprivate let indicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView.init(activityIndicatorStyle: .gray)
        indicatorView.isHidden = true
        return indicatorView
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel.text = loadingMoreDescription
        addSubview(titleLabel)
        addSubview(indicatorView)
    }
    
    public required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func refreshAnimationBegin(view: ESRefreshComponent) {
        indicatorView.startAnimating()
        titleLabel.text = loadingDescription
        indicatorView.isHidden = false
    }
    
    open func refreshAnimationEnd(view: ESRefreshComponent) {
        indicatorView.stopAnimating()
        titleLabel.text = loadingMoreDescription
        indicatorView.isHidden = true
    }
    
    open func refresh(view: ESRefreshComponent, progressDidChange progress: CGFloat) {
        // do nothing
    }
    
    open func refresh(view: ESRefreshComponent, stateDidChange state: ESRefreshViewState) {
        guard self.state != state else {
            return
        }
        self.state = state
        
        switch state {
        case .refreshing, .autoRefreshing :
            titleLabel.text = loadingDescription
            break
        case .noMoreData:
            titleLabel.text = noMoreDataDescription
            break
        case .pullToRefresh:
            titleLabel.text = loadingMoreDescription
            break
        default:
            break
        }
        self.setNeedsLayout()
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        let s = self.bounds.size
        let w = s.width
        let h = s.height
        
        titleLabel.sizeToFit()
        titleLabel.center = CGPoint.init(x: w / 2.0, y: h / 2.0 - 5.0)
        indicatorView.center = CGPoint.init(x: titleLabel.frame.origin.x - 18.0, y: titleLabel.center.y)
    }
}
