//
//  LogRecordViewModel.swift
//  Pods
//
//  Created by zixun on 16/12/28.
//
//

import Foundation
import AppBaseKit

class LogRecordViewModel: BaseRecordViewModel {
    
    private(set) var model:LogRecordModel!
    
    init(_ model:LogRecordModel) {
        super.init()
        self.model = model
        
    }
    func attributeString() -> NSAttributedString {
        
        let result = NSMutableAttributedString()
        
        result.append(self.headerString())
        if let additon = self.additionString() {
            result.append(additon)
        }
        return result
    }
    
    private func headerString() -> NSAttributedString {
        return self.headerString(with: self.model.type.string(), content: self.model.message, color: self.model.type.color())
    }
    
    private func additionString() ->NSAttributedString? {
        if self.model.type == .asl {
            return nil
        }
        
        let date = self.model.date ?? ""
        let thread = self.model.thread ?? ""
        let file = self.model.file ?? ""
        let line = self.model.line ?? -1
        let function = self.model.function ?? ""
        
        var content: String = "[\(file): \(line)](\(function)) \(date) -> \(thread)"
        let result = NSMutableAttributedString(attributedString: self.contentString(with: nil, content: content))
        let  range = result.string.NS.range(of: content)
        if range.location != NSNotFound {
            let att = [NSFontAttributeName:UIFont(name: "Courier", size: 10)!,
                       NSForegroundColorAttributeName:UIColor.white] as [String : Any]
            result.setAttributes(att, range: range)
        }
        return result
        
    }
}
