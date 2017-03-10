//
//  LeakEye.swift
//  Pods
//
//  Created by zixun on 16/12/12.
//
//

import Foundation

//--------------------------------------------------------------------------
// MARK: - LeakEyeDelegate
//--------------------------------------------------------------------------
@objc public protocol LeakEyeDelegate: NSObjectProtocol {
   @objc optional func leakEye(leakEye:LeakEye,didCatchLeak object:NSObject)
}

//--------------------------------------------------------------------------
// MARK: - LeakEye
//--------------------------------------------------------------------------
open class LeakEye: NSObject {
    
    //--------------------------------------------------------------------------
    // MARK: OPEN PROPERTY
    //--------------------------------------------------------------------------
    open weak var delegate: LeakEyeDelegate?
    
    open var isOpening: Bool {
        get {
            return self.timer?.isValid ?? false
        }
    }
    //--------------------------------------------------------------------------
    // MARK: LIFE CYCLE
    //--------------------------------------------------------------------------
    public override init() {
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(LeakEye.receive), name: NSNotification.Name.receive, object: nil)
    }
    
    //--------------------------------------------------------------------------
    // MARK: OPEN FUNCTION
    //--------------------------------------------------------------------------
    open func open() {
        Preparer.binding()
        self.startPingTimer()
    }
    
    open func close() {
        self.timer?.invalidate()
        self.timer = nil
    }
    
    private func startPingTimer() {
        if Thread.isMainThread == false {
            DispatchQueue.main.async {
                self.startPingTimer()
                return
            }
        }
        self.close()
        
        self.timer = Timer.scheduledTimer(timeInterval: 0.5,
                                          target: self,
                                          selector: #selector(LeakEye.scan),
                                          userInfo: nil,
                                          repeats: true)
        
    }
    
    //--------------------------------------------------------------------------
    // MARK: PRIVATE FUNCTION
    //--------------------------------------------------------------------------
    @objc private func scan()  {
        NotificationCenter.default.post(name: NSNotification.Name.scan, object: nil)
    }
    
    @objc private func receive(notif:NSNotification) {
        guard let leakObj = notif.object as? NSObject else {
            return
        }
        self.delegate?.leakEye?(leakEye: self, didCatchLeak: leakObj)
    }
    
    //--------------------------------------------------------------------------
    // MARK: PRIVATE PROPEERTY
    //--------------------------------------------------------------------------
    private var timer: Timer?
}
