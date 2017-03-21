//
//  Net.swift
//  Pods
//
//  Created by zixun on 16/12/26.
//
//

import Foundation

@objc public protocol NetDelegate: class {
    @objc optional func networkFlow(networkFlow:NetworkFlow,catchWithWifiSend wifiSend:UInt32,wifiReceived:UInt32,wwanSend:UInt32,wwanReceived:UInt32)
}

open class NetworkFlow: NSObject {
    
    open weak var delegate: NetDelegate?
    
    private var eyeThread: Thread?
    private var timeInterval:TimeInterval!
    
    open func open(with timeInterval:TimeInterval = 1) {
        self.timeInterval = timeInterval
        self.close()
        self.eyeThread = Thread(target: self, selector: #selector(NetworkFlow.eyeThreadHandler), object: nil)
        self.eyeThread?.name = "SystemEye_Net";
        self.eyeThread?.start()
    }
    
    open func close() {
        self.eyeThread?.cancel()
        self.eyeThread = nil
    }
    
    
    @objc private func eyeThreadHandler() {
        while true {
            if Thread.current.isCancelled {
                Thread.exit()
            }
            self.execute()
            Thread.sleep(forTimeInterval: self.timeInterval)
        }
    }
    
    func execute() {
        
        let model = NetObjc.flow()
        
        if self.first_model == nil {
            self.first_model = model
        }else {
            model.wifiSend -= self.first_model!.wifiSend
            model.wifiReceived -= self.first_model!.wifiReceived
            model.wwanSend -= self.first_model!.wwanSend
            model.wwanReceived -= self.first_model!.wwanReceived
        }
        self.delegate?.networkFlow?(networkFlow: self,
                                    catchWithWifiSend: model.wifiSend,
                                    wifiReceived: model.wifiReceived,
                                    wwanSend: model.wwanSend,
                                    wwanReceived: model.wwanReceived)
    }
    
    private var first_model: NetModel?
}
