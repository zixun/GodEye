//
//  EyesManager.swift
//  Pods
//
//  Created by zixun on 17/1/18.
//
//

import Foundation
import ASLEye
import NetworkEye_swift
import Log4G
import CrashEye
import ANREye
import LeakEye

class EyesManager: NSObject {
    
    static let shared = EyesManager()
    
    weak var delegate:ConsoleController?
    
    fileprivate lazy var aslEye: ASLEye = { [unowned self] in
        let new = ASLEye()
        new.delegate = self.delegate
        return new
    }()
    
    fileprivate lazy var anrEye: ANREye = { [unowned self] in
        let new = ANREye()
        new.delegate = self.delegate
        return new
    }()
    
    fileprivate lazy var leakEye: LeakEye = { [unowned self] in
        let new = LeakEye()
        new.delegate = self.delegate
        return new
    }()
}

//--------------------------------------------------------------------------
// MARK: - ASL EYE
//--------------------------------------------------------------------------
extension EyesManager {
    
    func isASLEyeOpening() -> Bool {
        return self.aslEye.isOpening
    }
    
    /// open asl eye
    func openASLEye() {
        self.aslEye.delegate = self.delegate!
        self.aslEye.open(with: 1)
    }
    
    /// close asl eys
    func closeASLEye() {
        self.aslEye.close()
    }
}

//--------------------------------------------------------------------------
// MARK: - LOG4G
//--------------------------------------------------------------------------
extension EyesManager {
    
    func isLog4GEyeOpening() -> Bool {
        return Log4G.delegateCount > 0
    }
    
    func openLog4GEye() {
        Log4G.add(delegate: self.delegate!)
    }
    
    func closeLog4GEye() {
        Log4G.remove(delegate: self.delegate!)
    }
}

//--------------------------------------------------------------------------
// MARK: - CRASH
//--------------------------------------------------------------------------
extension EyesManager {
    
    func isCrashEyeOpening() -> Bool {
        return CrashEye.isOpen
    }
    
    func openCrashEye() {
        CrashEye.add(delegate: self.delegate!)
    }
    
    func closeCrashEye() {
        CrashEye.remove(delegate: self.delegate!)
    }
}

//--------------------------------------------------------------------------
// MARK: - NETWORK
//--------------------------------------------------------------------------
extension EyesManager {
    
    func isNetworkEyeOpening() -> Bool {
        return NetworkEye.isWatching
    }
    
    func openNetworkEye() {
        NetworkEye.add(observer: self.delegate!)
    }
    
    func closeNetworkEye() {
        NetworkEye.remove(observer: self.delegate!)
    }
}

//--------------------------------------------------------------------------
// MARK: - ANREye
//--------------------------------------------------------------------------
extension EyesManager {
    func isANREyeOpening() -> Bool {
        return self.anrEye.isOpening
    }
    
    func openANREye() {
        self.anrEye.open(with: 2)
    }
    
    func closeANREye() {
        self.anrEye.close()
    }
}

extension EyesManager {
    
    func isLeakEyeOpening() -> Bool {
        return self.leakEye.isOpening
    }
    
    func openLeakEye() {
        self.leakEye.open()
    }
    
    func closeLeakEye() {
        self.leakEye.close()
    }
}
