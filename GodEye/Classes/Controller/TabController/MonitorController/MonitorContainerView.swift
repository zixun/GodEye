//
//  MonitorContainerView.swift
//  Pods
//
//  Created by zixun on 17/1/6.
//
//

import Foundation
import UIKit
import SystemEye

protocol MonitorContainerViewDelegate: class {
    func container(container:MonitorContainerView, didSelectedType type:MonitorSystemType)
}

class MonitorContainerView: UIScrollView,FPSDelegate,NetDelegate {
    
    weak var delegateContainer: MonitorContainerViewDelegate?
    
    init() {
        super.init(frame: CGRect.zero)
        
        self.addSubview(self.deviceView)
        self.addSubview(self.sysNetView)
        
        self.fps.open()
        self.networkFlow.open()
        
        self.deviceView.configure(nameString: System.hardware.deviceModel,
                                  osString: System.hardware.systemName + " " + System.hardware.systemVersion)
        
        Store.shared.networkByteDidChange { [weak self] (byte:Double) in
            self?.appNetView.configure(byte: byte)
        }
        
        
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MonitorContainerView.timerHandler), userInfo: nil, repeats: true)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
       
        self.deviceView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: 100)
        
        
        for i in 0..<self.monitorAppViews.count {
            var rect = self.deviceView.frame
            rect.origin.y = rect.maxY
            rect.size.width = self.frame.size.width / 2.0
            rect.size.height = 100
            
            
            rect.origin.y += rect.size.height * CGFloat( i / 2)
            rect.origin.x += rect.size.width * CGFloat( i % 2)
            
            self.monitorAppViews[i].frame = rect
        }
        
        for i in 0..<self.monitorSysViews.count {
            var rect = self.monitorAppViews.last?.frame ?? CGRect.zero
            rect.origin.y += rect.size.height
            rect.origin.x = 0
            
            rect.origin.y += rect.size.height * CGFloat( i / 2)
            rect.origin.x += rect.size.width * CGFloat( i % 2)
            
            self.monitorSysViews[i].frame = rect
        }
        
        var rect = self.monitorSysViews.last?.frame ?? CGRect.zero
        rect.origin.y += rect.size.height
        rect.origin.x = 0
        rect.size.width = self.frame.size.width
        self.sysNetView.frame = rect
        
        self.contentSize = CGSize(width: self.frame.size.width, height: self.sysNetView.frame.maxY)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    //--------------------------------------------------------------------------
    // MARK: PRIVATE FUNCTION
    //--------------------------------------------------------------------------
    
    @objc private func didTap(sender:MonitorBaseView) {
        self.delegateContainer?.container(container: self, didSelectedType: sender.type)
    }
    
    @objc private func didTapSysNetView(sender:MonitorSysNetFlowView) {
        self.delegateContainer?.container(container: self, didSelectedType: sender.type)
    }
    
    @objc private func timerHandler() {
        
        self.appCPUView.configure(percent: System.cpu.applicationUsage())
        
        let cpuSystemUsage = System.cpu.systemUsage()
        self.sysCPUView.configure(percent: cpuSystemUsage.system + cpuSystemUsage.user + cpuSystemUsage.nice)
        
        self.appRAMView.configure(byte: System.memory.applicationUsage().used)
        
        let ramSysUsage = System.memory.systemUsage()
        let percent = (ramSysUsage.active + ramSysUsage.inactive + ramSysUsage.wired) / ramSysUsage.total
        self.sysRAMView.configure(percent: percent * 100.0)
        
    }
    
    func fps(fps:FPS, currentFPS:Double) {
        self.appFPSView.configure(fps: currentFPS)
    }
    
    func networkFlow(networkFlow:NetworkFlow,catchWithWifiSend wifiSend:UInt32,wifiReceived:UInt32,wwanSend:UInt32,wwanReceived:UInt32) {
        self.sysNetView.configure(wifiSend: wifiSend, wifiReceived: wifiReceived, wwanSend: wwanSend, wwanReceived: wwanReceived)
    }
    //--------------------------------------------------------------------------
    // MARK: PRIVATE PROPERTY
    //--------------------------------------------------------------------------
    
    private lazy var fps: FPS = { [unowned self] in
        let new = FPS()
        new.delegate = self
        return new
    }()
    
    private lazy var networkFlow: NetworkFlow = {
        let new = NetworkFlow()
        new.delegate = self
        return new
    }()
    
    private var deviceView = MonitorDeviceView()
    
    private lazy var appCPUView: MonitorBaseView = { [unowned self] in
        let new = MonitorBaseView(type: MonitorSystemType.appCPU)
        new.addTarget(self, action: #selector(MonitorContainerView.didTap(sender:)), for: .touchUpInside)
        return new
    }()
    
    private lazy var appRAMView: MonitorBaseView = { [unowned self] in
        let new = MonitorBaseView(type: MonitorSystemType.appRAM)
        new.addTarget(self, action: #selector(MonitorContainerView.didTap(sender:)), for: .touchUpInside)
        return new
    }()
    
    private lazy var appFPSView: MonitorBaseView = { [unowned self] in
        let new = MonitorBaseView(type: MonitorSystemType.appFPS)
        new.addTarget(self, action: #selector(MonitorContainerView.didTap(sender:)), for: .touchUpInside)
        return new
    }()
    
    private lazy var appNetView: MonitorBaseView = { [unowned self] in
        let new = MonitorBaseView(type: MonitorSystemType.appNET)
        new.addTarget(self, action: #selector(MonitorContainerView.didTap(sender:)), for: .touchUpInside)
        return new
    }()

    private lazy var sysCPUView: MonitorBaseView = { [unowned self] in
        let new = MonitorBaseView(type: MonitorSystemType.sysCPU)
        new.addTarget(self, action: #selector(MonitorContainerView.didTap(sender:)), for: .touchUpInside)
        return new
    }()
    
    private lazy var sysRAMView: MonitorBaseView = { [unowned self] in
        let new = MonitorBaseView(type: MonitorSystemType.sysRAM)
        new.addTarget(self, action: #selector(MonitorContainerView.didTap(sender:)), for: .touchUpInside)
        return new
    }()
    
    private lazy var sysNetView: MonitorSysNetFlowView = { [unowned self] in
        let new = MonitorSysNetFlowView(type: MonitorSystemType.sysNET)
        new.addTarget(self, action: #selector(MonitorContainerView.didTapSysNetView(sender:)), for: .touchUpInside)
        return new
    }()
    
    private lazy var monitorAppViews: [MonitorBaseView] = { [unowned self] in
        var new = [MonitorBaseView]()
        
        self.addSubview(self.appCPUView)
        self.addSubview(self.appRAMView)
        self.addSubview(self.appFPSView)
        self.addSubview(self.appNetView)
        
        new.append(self.appCPUView)
        new.append(self.appRAMView)
        new.append(self.appFPSView)
        new.append(self.appNetView)
        
        for i in 0..<new.count {
            new[i].firstRow = i < 2
            new[i].position = i % 2 == 0 ? .left : .right
        }
        return new
    }()
    
    private lazy var monitorSysViews: [MonitorBaseView] = { [unowned self] in
        var new = [MonitorBaseView]()
        
        self.addSubview(self.sysCPUView)
        self.addSubview(self.sysRAMView)
        new.append(self.sysCPUView)
        new.append(self.sysRAMView)
        
        for i in 0..<new.count {
            new[i].firstRow = i < 2
            new[i].position = i % 2 == 0 ? .left : .right
        }
        return new
    }()
}

//extension MonitorContainerView : SystemStoreDelegate {
//    func systemStoreDidCatch(cpu model:CPUModel) {
//        self.appCPUView.configure(application: model.application)
//        self.sysCPUView.configure(system: model.system)
//    }
//    func systemStoreDidCatch(memory model:MemoryModel) {
//        self.appRAMView.configure(appMemory: model.application)
//        self.sysRAMView.configure(systemRAM: model.system)
//    }
//    func systemStoreDidCatch(fps model:Double) {
//        self.appFPSView.configure(fps: model)
//    }
//    func systemStoreDidCatch(net model:NetModel) {
//        self.sysNetView.configure(net: model)
//    }
//}
