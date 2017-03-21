//
//  ANREye.swift
//  Pods
//
//  Created by zixun on 16/12/24.
//
//

import Foundation

//--------------------------------------------------------------------------
// MARK: - ANREyeDelegate
//--------------------------------------------------------------------------
@objc public protocol ANREyeDelegate: class {
    @objc optional func anrEye(anrEye:ANREye,
                               catchWithThreshold threshold:Double,
                               mainThreadBacktrace:String?,
                               allThreadBacktrace:String?)
}

//--------------------------------------------------------------------------
// MARK: - ANREye
//--------------------------------------------------------------------------
open class ANREye: NSObject {
    
    //--------------------------------------------------------------------------
    // MARK: OPEN PROPERTY
    //--------------------------------------------------------------------------
    open weak var delegate: ANREyeDelegate?
    
    open var isOpening: Bool {
        get {
            guard let pingThread = self.pingThread else {
                return false
            }
            return !pingThread.isCancelled
        }
    }
    //--------------------------------------------------------------------------
    // MARK: OPEN FUNCTION
    //--------------------------------------------------------------------------
    
    open func open(with threshold:Double) {
        if Thread.current.isMainThread {
            AppBacktrace.main_thread_id = mach_thread_self()
        }else {
            DispatchQueue.main.async {
                AppBacktrace.main_thread_id = mach_thread_self()
            }
        }
        
        self.pingThread = AppPingThread()
        self.pingThread?.start(threshold: threshold, handler: { [weak self] in
            guard let sself = self else {
                return
            }
            
            let main = AppBacktrace.mainThread()
            let all = AppBacktrace.allThread()
            sself.delegate?.anrEye?(anrEye: sself,
                                   catchWithThreshold: threshold,
                                   mainThreadBacktrace: main,
                                   allThreadBacktrace: all)
            
        })
    }
    
    open func close() {
        self.pingThread?.cancel()
    }
    
    //--------------------------------------------------------------------------
    // MARK: LIFE CYCLE
    //--------------------------------------------------------------------------
    deinit {
        self.pingThread?.cancel()
    }
    
    //--------------------------------------------------------------------------
    // MARK: PRIVATE PROPERTY
    //--------------------------------------------------------------------------
    private var pingThread: AppPingThread?
    
}

//--------------------------------------------------------------------------
// MARK: - GLOBAL DEFINE
//--------------------------------------------------------------------------
public typealias AppPingThreadCallBack = () -> Void

//--------------------------------------------------------------------------
// MARK: - AppPingThread
//--------------------------------------------------------------------------
private class AppPingThread: Thread {
    
    func start(threshold:Double, handler: @escaping AppPingThreadCallBack) {
        self.handler = handler
        self.threshold = threshold
        self.start()
    }
    
    override func main() {
        
        while self.isCancelled == false {
            self.isMainThreadBlock = true
            DispatchQueue.main.async {
                self.isMainThreadBlock = false
                self.semaphore.signal()
            }
            
            Thread.sleep(forTimeInterval: self.threshold)
            if self.isMainThreadBlock  {
                self.handler?()
            }
            
            self.semaphore.wait(timeout: DispatchTime.distantFuture)
        }
    }
    
    private let semaphore = DispatchSemaphore(value: 0)
    
    private var isMainThreadBlock = false
    
    private var threshold: Double = 0.4
    
    fileprivate var handler: (() -> Void)?
}
