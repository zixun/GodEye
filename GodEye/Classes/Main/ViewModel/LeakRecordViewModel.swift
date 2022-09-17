//
//  LeakRecordViewModel.swift
//  Pods
//
//  Created by zixun on 17/1/12.
//
//

import Foundation

class LeakRecordViewModel: BaseRecordViewModel {
    
    private(set) var model:LeakRecordModel!
    
    init(_ model:LeakRecordModel) {
        super.init()
        self.model = model
    }
    
    func attributeString() -> NSAttributedString {
        
        let result = NSMutableAttributedString()
        
        result.append(self.headerString())
        return result
    }
    
    private func headerString() -> NSAttributedString {
        return self.headerString(with: "Leak", content: "[\(self.model.clazz): \(self.model.address)]", color: UIColor(hex: 0xB754C4))
    }
    
  
    
}
