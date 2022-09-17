//
//  NetworkRecordViewModel.swift
//  Pods
//
//  Created by zixun on 16/12/29.
//
//

import Foundation

class NetworkRecordViewModel: BaseRecordViewModel {
    
    private(set) var model: NetworkRecordModel!
    
    init(_ model:NetworkRecordModel) {
        super.init()
        self.model = model
    }
    
    func attributeString() -> NSAttributedString {
        
        let result = NSMutableAttributedString()
        
        result.append(self.headerString())
        result.append(self.requestURLString())
        
        if self.model.showAll {
            result.append(self.requestCachePolicyString())
            result.append(self.requestTimeoutIntervalString())
            result.append(self.requestHTTPMethodString())
            result.append(self.requestAllHTTPHeaderFieldsString())
            result.append(self.requestHTTPBodyString())
            result.append(self.responseMIMETypeString())
            result.append(self.responseExpectedContentLengthString())
            result.append(self.responseTextEncodingNameString())
            result.append(self.responseSuggestedFilenameString())
            result.append(self.responseStatusCodeString())
            result.append(self.responseAllHeaderFieldsString())
            result.append(self.receiveJSONDataString())
        }else {
            result.append(self.contentString(with: "Click cell to show all", content: "...", newline: false, color: UIColor.cyan))
        }
        return result
    }
    
    private func headerString() -> NSAttributedString {
        return self.headerString(with: "NETWORK", color: UIColor(hex: 0xDF1921))
    }
    
    private func requestURLString() -> NSAttributedString {
        return self.contentString(with: "requestURL", content: self.model.requestURLString)
    }
    
    private func requestCachePolicyString() -> NSAttributedString {
        return self.contentString(with: "requestCachePolicy", content: self.model.requestCachePolicy)
    }
    
    private func requestTimeoutIntervalString() -> NSAttributedString {
        return self.contentString(with: "requestTimeoutInterval", content: self.model.requestTimeoutInterval)
    }
    
    private func requestHTTPMethodString() -> NSAttributedString {
        return self.contentString(with: "requestHTTPMethod", content: self.model.requestHTTPMethod)
    }
    
    private func requestAllHTTPHeaderFieldsString() -> NSAttributedString {
        return self.contentString(with: "requestAllHTTPHeaderFields", content: self.model.requestAllHTTPHeaderFields)
    }
    
    private func requestHTTPBodyString() -> NSAttributedString {
        return self.contentString(with: "requestHTTPBody", content: self.model.requestHTTPBody)
    }
    
    private func responseMIMETypeString() -> NSAttributedString {
        return self.contentString(with: "responseMIMEType", content: self.model.responseMIMEType)
    }
    
    private func responseExpectedContentLengthString() -> NSAttributedString {
        return self.contentString(with: "responseExpectedContentLength", content: "\((self.model.responseExpectedContentLength ?? 0) / 1024)KB")
    }
    
    private func responseTextEncodingNameString() -> NSAttributedString {
        return self.contentString(with: "responseTextEncodingName", content: self.model.responseTextEncodingName)
    }
    
    private func responseSuggestedFilenameString() -> NSAttributedString {
        return self.contentString(with: "responseSuggestedFilename", content: self.model.responseSuggestedFilename)
    }
    
    private func responseStatusCodeString() -> NSAttributedString {
        let status = "\(self.model.responseStatusCode ?? 200)"
        let str = self.contentString(with: "responseStatusCode", content: status)
        let result = NSMutableAttributedString(attributedString: str)
        let  range = result.string.NS.range(of: status)
        if range.location != NSNotFound {
            let color = status == "200" ? UIColor(hex: 0x1CC221) : UIColor(hex: 0xF5261C)
            result.addAttribute(NSAttributedStringKey.foregroundColor, value: color, range: range)
        }
        return result
    }
    
    private func responseAllHeaderFieldsString() -> NSAttributedString {
        let str = self.contentString(with: "responseAllHeaderFields", content: self.model.responseAllHeaderFields,newline: true)
        let result = NSMutableAttributedString(attributedString: str)
        
        guard let responseAllHeaderFields = self.model.responseAllHeaderFields else {
            return result
        }
        
        let range = result.string.NS.range(of: responseAllHeaderFields)
        if range.location != NSNotFound {
            result.addAttribute(NSAttributedStringKey.font, value: UIFont.courier(with: 6), range: range)
        }
        return result
    }
    
    private func receiveJSONDataString() -> NSAttributedString {
        guard let transString = self.replaceUnicode(string: self.model.receiveJSONData) else {
            return NSAttributedString(string: "")
        }
        
        guard let responseMIMEType = self.model.responseMIMEType else {
            return NSAttributedString(string: "")
        }
        
        var header = "responseJSON"
        if responseMIMEType == "application/xml"
            || responseMIMEType == "text/xml"
            || responseMIMEType == "text/plain"  {
            header = "responseXML"
        }
        
        var result = NSMutableAttributedString(attributedString: self.contentString(with: header, content: transString,newline: true))
        let range = result.string.NS.range(of: transString)
        if range.location != NSNotFound {
            result.addAttribute(NSAttributedStringKey.font, value: UIFont.courier(with: 6), range: range)
        }
        
        return result
    }
    
    private func replaceUnicode(string:String?) -> String? {
        guard let string = string else {
            return nil
        }
        
        var result = string.replacingOccurrences(of: "\\u", with: "\\U").replacingOccurrences(of: "\"", with: "\\\"")
        result = "\"" + result + "\""
        
        
        if let data = result.data(using: String.Encoding.utf8) {
            do {
                result = try PropertyListSerialization.propertyList(from: data, options: PropertyListSerialization.ReadOptions.mutableContainers, format: nil) as! String
                result = result.replacingOccurrences(of: "\\r\\n", with: "\n")
                
                return result
            } catch  {
                return nil
            }
            
            
        }
        
        return nil
    }
    
}
