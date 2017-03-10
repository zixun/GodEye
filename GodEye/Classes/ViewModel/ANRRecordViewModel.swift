//
//  ANRRecordViewModel.swift
//  Pods
//
//  Created by zixun on 16/12/30.
//
//

import Foundation

class ANRRecordViewModel: BaseRecordViewModel {
    
    private(set) var model:ANRRecordModel!
    
    init(_ model:ANRRecordModel) {
        super.init()
        self.model = model
    }
    
    func attributeString() -> NSAttributedString {
        
        let result = NSMutableAttributedString()
        result.append(self.headerString())
        result.append(self.mainThreadBacktraceString())
        
        if self.model.showAll {
            result.append(self.allThreadBacktraceString())
        }else {
            result.append(self.contentString(with: "Click cell to show all", content: "...", newline: false, color: UIColor.cyan))
        }
        
        
        return result
    }
    
    private func headerString() -> NSAttributedString {
        let content = "main thread not response with threshold:\(self.model.threshold!)"
        return self.headerString(with: "ANR", content: content, color: UIColor(hex: 0xFF0000))
    }
    
    private func mainThreadBacktraceString() -> NSAttributedString {
        let result = NSMutableAttributedString(attributedString: self.contentString(with: "MainThread Backtrace", content: self.model.mainThreadBacktrace, newline: true))
        let  range = result.string.NS.range(of: self.model.mainThreadBacktrace!)
        if range.location != NSNotFound {
            let att = [NSFontAttributeName:UIFont(name: "Courier", size: 6)!,
                       NSForegroundColorAttributeName:UIColor.white] as [String : Any]
            result.setAttributes(att, range: range)
            
        }
        return result
        
    }
    
    private func allThreadBacktraceString() -> NSAttributedString {
        let result = NSMutableAttributedString(attributedString: self.contentString(with: "AllThread Backtrace", content: self.model.allThreadBacktrace, newline: true))
        let  range = result.string.NS.range(of: self.model.allThreadBacktrace!)
        if range.location != NSNotFound {
            let att = [NSFontAttributeName:UIFont(name: "Courier", size: 6)!,
                       NSForegroundColorAttributeName:UIColor.white] as [String : Any]
            result.setAttributes(att, range: range)
            
        }
        return result
        
    }
    
}
