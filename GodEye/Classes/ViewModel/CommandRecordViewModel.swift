//
//  CommandRecordViewModel.swift
//  Pods
//
//  Created by zixun on 17/1/7.
//
//

import Foundation

class CommandRecordViewModel: BaseRecordViewModel {
    
    private(set) var model:CommandRecordModel!
    
    init(_ model:CommandRecordModel) {
        super.init()
        self.model = model
    }
    
    func attributeString() -> NSAttributedString {
        
        let result = NSMutableAttributedString()
        
        result.append(self.headerString())
        result.append(self.actionString())
        return result
    }
    
    private func headerString() -> NSAttributedString {
        return self.headerString(with: "Command", content: self.model.command, color: UIColor(hex: 0xB754C4))
    }
    
    private func actionString() -> NSAttributedString {
        return NSAttributedString(string: self.model.actionResult, attributes: self.attributes)
    }
    
    
}
