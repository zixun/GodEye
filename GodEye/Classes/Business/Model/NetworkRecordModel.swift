//
//  NetworkRecordModel.swift
//  Pods
//
//  Created by zixun on 16/12/29.
//
//

import Foundation
import SQLite

final class NetworkRecordModel: NSObject {
    
    /// Request
    fileprivate(set) var requestURLString:String?
    fileprivate(set) var requestCachePolicy:String?
    fileprivate(set) var requestTimeoutInterval:String?
    fileprivate(set) var requestHTTPMethod:String?
    fileprivate(set) var requestAllHTTPHeaderFields:String?
    fileprivate(set) var requestHTTPBody: String?
    
    /// Response
    fileprivate(set) var responseMIMEType: String?
    fileprivate(set) var responseExpectedContentLength: Int64 = 0
    fileprivate(set) var responseTextEncodingName: String?
    fileprivate(set) var responseSuggestedFilename:String?
    fileprivate(set) var responseStatusCode: Int = 200
    fileprivate(set) var responseAllHeaderFields: String?
    fileprivate(set) var receiveJSONData: String?
    
    
    /// init func, use for the data from NetworkEye
    ///
    /// - Parameters:
    ///   - request: instance of NSURLRequest
    ///   - response: intance of HTTPURLResponse
    ///   - data: response data
    init(request:URLRequest?, response: HTTPURLResponse?, data:Data?) {
        super.init()
        
        //request
        self.initialize(request: request)
       
        //response
        self.initialize(response: response, data: data)
        
        self.showAll = false
    }
    
    init(requestURLString:String?,
         requestCachePolicy:String?,
         requestTimeoutInterval:String?,
         requestHTTPMethod:String?,
         requestAllHTTPHeaderFields:String?,
         requestHTTPBody: String?,
         responseMIMEType: String?,
         responseExpectedContentLength: Int64,
         responseTextEncodingName: String?,
         responseSuggestedFilename:String?,
         responseStatusCode: Int,
         responseAllHeaderFields: String?,
         receiveJSONData: String?) {
        super.init()
        
        self.requestURLString = requestURLString
        self.requestCachePolicy = requestCachePolicy
        self.requestTimeoutInterval = requestTimeoutInterval
        self.requestHTTPMethod = requestHTTPMethod
        self.requestAllHTTPHeaderFields = requestAllHTTPHeaderFields
        self.requestHTTPBody = requestHTTPBody
        self.responseMIMEType = responseMIMEType
        self.responseExpectedContentLength = responseExpectedContentLength
        self.responseTextEncodingName = responseTextEncodingName
        self.responseSuggestedFilename = responseSuggestedFilename
        self.responseStatusCode = responseStatusCode
        self.responseAllHeaderFields = responseAllHeaderFields
        self.receiveJSONData = receiveJSONData
        self.showAll = false
    }
}

// MARK: - NetworkRecordModel Private
extension NetworkRecordModel {
    
    /// init the var of request
    ///
    /// - Parameter request: instance of NSURLRequest
    fileprivate func initialize(request:URLRequest?) {
        self.requestURLString = request?.url?.absoluteString
        self.requestCachePolicy = request?.cachePolicy.stringName()
        self.requestTimeoutInterval = request != nil ? String(request!.timeoutInterval) : "nil"
        self.requestHTTPMethod = request?.httpMethod
        
        if let allHTTPHeaderFields = request?.allHTTPHeaderFields {
            allHTTPHeaderFields.forEach({ [unowned self](e:(key: String, value: String)) in
                if self.requestAllHTTPHeaderFields == nil {
                    self.requestAllHTTPHeaderFields = "\(e.key):\(e.value)\n"
                }else {
                    self.requestAllHTTPHeaderFields!.append("\(e.key):\(e.value)\n")
                }
            })
        }
        
        if let bodyData = request?.httpBody {
            self.requestHTTPBody = String(data: bodyData, encoding: String.Encoding.utf8)
        }
    }
    
    /// init the var of response
    ///
    /// - Parameters:
    ///   - response: instance of HTTPURLResponse
    ///   - data: response data
    fileprivate func initialize(response: HTTPURLResponse?, data:Data?) {
        self.responseMIMEType = response?.mimeType
        self.responseExpectedContentLength = response?.expectedContentLength ?? 0
        self.responseTextEncodingName = response?.textEncodingName
        self.responseSuggestedFilename = response?.suggestedFilename
        
        self.responseStatusCode = response?.statusCode ?? 200
        
        response?.allHeaderFields.forEach { [unowned self] (e:(key: AnyHashable, value: Any)) in
            if self.responseAllHeaderFields == nil {
                self.responseAllHeaderFields = "\(e.key) : \(e.value)\n"
            }else {
                self.responseAllHeaderFields!.append("\(e.key) : \(e.value)\n")
            }
        }
        
        guard let data = data else {
            return
        }
        
        if self.responseMIMEType == "application/json" {
            self.receiveJSONData = self.json(from: data)
        }else if self.responseMIMEType == "text/javascript" {
            
            //try to parse json if it is jsonp request
            if var jsonString = String(data: data, encoding: String.Encoding.utf8) {
                //formalize string
                if jsonString.hasSuffix(")") {
                    jsonString = "\(jsonString);"
                }
                
                if jsonString.hasSuffix(");") {
                    var range = jsonString.NS.range(of: "(")
                    if range.location != NSNotFound {
                        range.location += 1
                        range.length = jsonString.NS.length - range.location - 2  // removes parens and trailing semicolon
                        jsonString = jsonString.NS.substring(with: range)
                        let jsondata = jsonString.data(using: String.Encoding.utf8)
                        self.receiveJSONData = self.json(from: jsondata)
                        
                    }
                }
            }
        }else if self.responseMIMEType == "application/xml" ||
            self.responseMIMEType == "text/xml" ||
            self.responseMIMEType == "text/plain" {
            let xmlString = String(data: data, encoding: String.Encoding.utf8)
            self.receiveJSONData = xmlString
        }else {
            self.receiveJSONData = "Untreated MimeType:\(self.responseMIMEType)"
        }
    }
    
    private func json(from data:Data?) -> String? {
        
        guard let data = data else {
            return nil
        }
        
        do {
            let returnValue = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            guard JSONSerialization.isValidJSONObject(returnValue) else {
                return nil;
            }
            let data = try JSONSerialization.data(withJSONObject: returnValue)
            return String(data: data, encoding: .utf8)
        } catch  {
            return nil
        }
    }
}


// MARK: - NSURLRequest.CachePolicy
extension NSURLRequest.CachePolicy {
    
    func stringName() -> String {
        
        switch self {
        case .useProtocolCachePolicy:
            return ".useProtocolCachePolicy"
        case .reloadIgnoringLocalCacheData:
            return ".reloadIgnoringLocalCacheData"
        case .reloadIgnoringLocalAndRemoteCacheData:
            return ".reloadIgnoringLocalAndRemoteCacheData"
        case .returnCacheDataElseLoad:
            return ".returnCacheDataElseLoad"
        case .returnCacheDataDontLoad:
            return ".returnCacheDataDontLoad"
        case .reloadRevalidatingCacheData:
            return ".reloadRevalidatingCacheData"
        }
        
    }
}
