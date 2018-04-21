//
//  ConsoleViewController+Eye.swift
//  Pods
//
//  Created by zixun on 16/12/28.
//
//

import Foundation
import ASLEye
import CrashEye
import NetworkEye
import ANREye
import Log4G
import LeakEye

extension ConsoleController {
    
    /// open god's eyes
    func openEyes() {
        EyesManager.shared.delegate = self
        
        let defaultSwitch = GodEyeController.shared.configuration!.defaultSwitch
        if defaultSwitch.asl { EyesManager.shared.openASLEye() }
        if defaultSwitch.log4g { EyesManager.shared.openLog4GEye() }
        if defaultSwitch.crash { EyesManager.shared.openCrashEye() }
        if defaultSwitch.network { EyesManager.shared.openNetworkEye() }
        if defaultSwitch.anr { EyesManager.shared.openANREye() }
        if defaultSwitch.leak { EyesManager.shared.openLeakEye() }
    }
    
    func addRecord(model:RecordORMProtocol) {
        if let pc = self.printViewController {
            pc.addRecord(model: model)
        }else {
            
            let type = Swift.type(of:model).type
            type.addUnread()
            self.reloadRow(of: type)
        }
    }
}

extension ConsoleController: Log4GDelegate {
    
    fileprivate func openLog4GEye() {
        Log4G.add(delegate: self)
    }
    
    func log4gDidRecord(with model:LogModel) {
        
        let recordModel = LogRecordModel(model: model)
        recordModel.insert(complete: { [unowned self] (success:Bool) in
            self.addRecord(model: recordModel)
        })
    }
}

//MARK: - NetworkEye
extension ConsoleController: NetworkEyeDelegate {
    /// god's network eye callback
    func networkEyeDidCatch(with request:URLRequest?,response:URLResponse?,data:Data?) {
        Store.shared.addNetworkByte(response?.expectedContentLength ?? 0)
        let model = NetworkRecordModel(request: request, response: response as? HTTPURLResponse, data: data)
        
        model.insert(complete:  { [unowned self] (success:Bool) in
            self.addRecord(model: model)
        })
    }
}
//MARK: - CrashEye
extension ConsoleController: CrashEyeDelegate {
    
    /// god's crash eye callback
    func crashEyeDidCatchCrash(with model:CrashModel) {
        let model = CrashRecordModel(model: model)
        model.insertSync(complete: { [unowned self] (success:Bool) in
            self.addRecord(model: model)
        })
    }
}

//MARK: - ASLEye
extension ConsoleController: ASLEyeDelegate {
    
    
    
    /// god's asl eye callback
    func aslEye(aslEye:ASLEye,catchLogs logs:[String]) {
        for log in logs {
            let model = LogRecordModel(type: .asl, message: log)
            model.insert(complete: { [unowned self] (success:Bool) in
                self.addRecord(model: model)
            })
        }
    }
}

extension ConsoleController: LeakEyeDelegate {
    
    func leakEye(leakEye:LeakEye,didCatchLeak object:NSObject) {
        let model = LeakRecordModel(obj: object)
        model.insert { [unowned self] (success:Bool) in
            self.addRecord(model: model)
        }
    }
}

//MARK: - ANREye
extension ConsoleController: ANREyeDelegate {
    /// god's anr eye callback
    func anrEye(anrEye:ANREye,
                catchWithThreshold threshold:Double,
                mainThreadBacktrace:String?,
                allThreadBacktrace:String?) {
        let model = ANRRecordModel(threshold: threshold,
                                   mainThreadBacktrace: mainThreadBacktrace,
                                   allThreadBacktrace: allThreadBacktrace)
        model.insert(complete:  { [unowned self] (success:Bool) in
            self.addRecord(model: model)
        })
    }
}
