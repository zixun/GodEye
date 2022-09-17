//
//  RecordTableView.swift
//  Pods
//
//  Created by zixun on 16/12/28.
//
//

import Foundation

class RecordTableView: UITableView {
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.separatorStyle = .none
        self.backgroundColor = UIColor.niceBlack()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func smoothReloadData(need scrollToBottom: Bool) {
        self.timer?.invalidate()
        self.timer = nil
        self.needScrollToBottom = false
        
        self.timer = Timer.scheduledTimer(timeInterval: 0.5,
                                          target: self,
                                          selector: #selector(RecordTableView.reloadData),
                                          userInfo: nil,
                                          repeats: false)
    }
    
    override func reloadData() {
        super.reloadData()
        
        if self.needScrollToBottom == true {
            DispatchQueue.main.async {
                self.scrollToBottom(animated: true)
            }
        }
    }
    
    func scrollToBottom(animated: Bool) {
        let point = CGPoint(x: 0, y: max(self.contentSize.height + self.contentInset.bottom - self.bounds.size.height, 0))
        self.setContentOffset(point, animated: animated)
    }
    
    private var timer: Timer?
    
    private var needScrollToBottom = false
}

class RecordTableViewDataSource: NSObject {
    private let maxLogItems: Int = 1000
    
    fileprivate(set) var recordData: [RecordORMProtocol]!
    
    private var logIndex: Int = 0
    fileprivate var type: RecordType!
    init(type:RecordType) {
        super.init()
        self.type = type
        
        self.type.model()?.addCount = 0
        self.recordData = self.currentPageModel()
    }
    
    private func currentPageModel() -> [RecordORMProtocol]? {
        if self.type == RecordType.log {
            return LogRecordModel.select(at: self.logIndex)
        }else if self.type == RecordType.crash {
            return CrashRecordModel.select(at: self.logIndex)
        }else if self.type == .network {
            return NetworkRecordModel.select(at: self.logIndex)
        }else if self.type == .anr {
            return ANRRecordModel.select(at: self.logIndex)
        }else if self.type == .command {
            return CommandRecordModel.select(at: self.logIndex)
        }else if self.type == .leak {
            return LeakRecordModel.select(at: self.logIndex)
        }
        
        fatalError("type:\(self.type) not define the database")
    }
    
    private func addCount() {
        self.type.model()?.addCount += 1
    }
    
    func loadPrePage() -> Bool {
        self.logIndex += 1
        
        guard let models = self.currentPageModel() else {
            return false
        }
        
        guard models.count != 0 else {
            return false
        }
        
        for model in models.reversed() {
            self.recordData.insert(model, at: 0)
        }
        return true
    }
    
    func addRecord(model:RecordORMProtocol) {
        
        if self.recordData.count != 0 &&
            Swift.type(of: model).type != self.type {
            return
        }
        
        self.recordData.append(model)
        if self.recordData.count > self.maxLogItems {
            self.recordData.remove(at: 0)
        }
        self.addCount()
    }
    
    func cleanRecord() {
        self.recordData.removeAll()
    }
}

extension RecordTableViewDataSource: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.recordData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return tableView.dequeueReusableCell({ (cell:RecordTableViewCell) in
            
        })
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = cell as? RecordTableViewCell
        
        let attributeString = self.recordData[indexPath.row].attributeString()
        cell?.configure(attributeString)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let tableView = tableView as! RecordTableView
        
        let width = tableView.bounds.size.width - 10
        let attributeString = self.recordData[indexPath.row].attributeString()
        return RecordTableViewCell.boundingHeight(with: width, attributedText: attributeString)
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if self.type == .network || self.type == .anr {
            return indexPath
        }else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.recordData[indexPath.row]
        model.showAll = !model.showAll
        tableView.reloadData()
    }
}

