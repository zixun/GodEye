//
//  ESRefreshProtocol.swift
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

import Foundation
import UIKit

public enum ESRefreshViewState {
    case pullToRefresh
    case releaseToRefresh
    case refreshing
    case autoRefreshing
    case noMoreData
}

/**
 *  ESRefreshProtocol
 *  Animation event handling callback protocol
 *  You can customize the refresh or custom animation effects
 *  Mutating is to be able to modify or enum struct variable in the method - http://swifter.tips/protocol-mutation/ by ONEVCAT
 */
public protocol ESRefreshProtocol {
    
    /**
     Refresh operation begins execution method
     You can refresh your animation logic here, it will need to start the animation each time a refresh
    */
    mutating func refreshAnimationBegin(view: ESRefreshComponent)
    
    /**
     Refresh operation stop execution method
     Here you can reset your refresh control UI, such as a Stop UIImageView animations or some opened Timer refresh, etc., it will be executed once each time the need to end the animation
     */
    mutating func refreshAnimationEnd(view: ESRefreshComponent)
    
    /**
     Pulling status callback , progress is the percentage of the current offset with trigger, and avoid doing too many tasks in this process so as not to affect the fluency.
     */
    mutating func refresh(view: ESRefreshComponent, progressDidChange progress: CGFloat)
    
    mutating func refresh(view: ESRefreshComponent, stateDidChange state: ESRefreshViewState)
}


public protocol ESRefreshAnimatorProtocol {
    
    // The view that called when component refresh, returns a custom view or self if 'self' is the customized views.
    var view: UIView {get}
    
    // Customized inset.
    var insets: UIEdgeInsets {set get}
    
    // Refresh event is executed threshold required y offset, set a value greater than 0.0, the default is 60.0
    var trigger: CGFloat {set get}
    
    // Offset y refresh event executed by this parameter you can customize the animation to perform when you refresh the view of reservations height
    var executeIncremental: CGFloat {set get}
    
    // Current refresh state, default is .pullToRefresh
    var state: ESRefreshViewState {set get}
    
}

/**
 *  ESRefreshImpacter
 *  Support iPhone7/iPhone7 Plus or later feedback impact
 *  You can confirm the ESRefreshImpactProtocol
 */
fileprivate class ESRefreshImpacter {
    static private var impacter: AnyObject? = {
        if #available(iOS 10.0, *) {
            if NSClassFromString("UIFeedbackGenerator") != nil {
                let generator = UIImpactFeedbackGenerator.init(style: .light)
                generator.prepare()
                return generator
            }
        }
        return nil
    }()
    
    static open func impact() -> Void {
        if #available(iOS 10.0, *) {
            if let impacter = impacter as? UIImpactFeedbackGenerator {
                impacter.impactOccurred()
            }
        }
    }
}

public protocol ESRefreshImpactProtocol {}
public extension ESRefreshImpactProtocol {
    
    public func impact() -> Void {
        ESRefreshImpacter.impact()
    }
    
}
