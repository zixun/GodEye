//
//  EyeProtocol.swift
//  Pods
//
//  Created by zixun on 16/12/25.
//
//

import Foundation



class EyeProtocol: URLProtocol {
    
    class func open() {
        URLProtocol.registerClass(self.classForCoder())
    }
    
    class func close() {
        URLProtocol.unregisterClass(self.classForCoder())
    }
    
    open class func add(delegate:NetworkEyeDelegate) {
        // delete null week delegate
        self.delegates = self.delegates.filter {
            return $0.delegate != nil
        }
        
        // judge if contains the delegate from parameter
        let contains = self.delegates.contains {
            return $0.delegate?.hash == delegate.hash
        }
        // if not contains, append it with weak wrapped
        if contains == false {
            let week = WeakNetworkEyeDelegate(delegate: delegate)
            
            self.delegates.append(week)
        }
    }
    
    open class func remove(delegate:NetworkEyeDelegate) {
        self.delegates = self.delegates.filter {
            // filter null weak delegate
            return $0.delegate != nil
            }.filter {
                // filter the delegate from parameter
                return $0.delegate?.hash != delegate.hash
        }
    }
    
    fileprivate var connection: NSURLConnection?
    
    fileprivate var ca_request: URLRequest?
    fileprivate var ca_response: URLResponse?
    fileprivate var ca_data:Data?
    
    fileprivate static let AppNetworkGreenCard = "AppNetworkGreenCard"
    
    private(set) static  var delegates = [WeakNetworkEyeDelegate]()
    
}

extension EyeProtocol {
    override class func canInit(with request: URLRequest) -> Bool {
        
        guard let scheme = request.url?.scheme else {
            return false
        }
        
        guard scheme == "http" || scheme == "https" else {
            return false
        }
        
        guard URLProtocol.property(forKey: AppNetworkGreenCard, in: request) == nil else {
            return false
        }
        
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        
        let req = (request as NSURLRequest).mutableCopy() as! NSMutableURLRequest
        URLProtocol.setProperty(true, forKey: AppNetworkGreenCard, in: req)
        return req.copy() as! URLRequest
    }
    
    override func startLoading() {
        let request = EyeProtocol.canonicalRequest(for: self.request)
        self.connection = NSURLConnection(request: request, delegate: self, startImmediately: true)
        
        self.ca_request = self.request
    }
    
    override func stopLoading() {
        self.connection?.cancel()
        for element in EyeProtocol.delegates {
            element.delegate?.networkEyeDidCatch(with: self.ca_request, response: self.ca_response, data: self.ca_data)
        }
    }
}

extension EyeProtocol: NSURLConnectionDelegate {
    func connection(_ connection: NSURLConnection, didFailWithError error: Error) {
        self.client?.urlProtocol(self, didFailWithError: error)
    }
    
    func connectionShouldUseCredentialStorage(_ connection: NSURLConnection) -> Bool {
        return true
    }
    
    func connection(_ connection: NSURLConnection, didReceive challenge: URLAuthenticationChallenge) {
        self.client?.urlProtocol(self, didReceive: challenge)
    }
    
    func connection(_ connection: NSURLConnection, didCancel challenge: URLAuthenticationChallenge) {
        self.client?.urlProtocol(self, didCancel: challenge)
    }
}

extension EyeProtocol: NSURLConnectionDataDelegate {
    
    func connection(_ connection: NSURLConnection, willSend request: URLRequest, redirectResponse response: URLResponse?) -> URLRequest? {
        if response != nil {
            self.ca_response = response
            self.client?.urlProtocol(self, wasRedirectedTo: request, redirectResponse: response!)
        }
        return request
    }
    
    func connection(_ connection: NSURLConnection, didReceive response: URLResponse) {
        self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: URLCache.StoragePolicy.allowed)
        self.ca_response = response
    }
    
    func connection(_ connection: NSURLConnection, didReceive data: Data) {
        self.client?.urlProtocol(self, didLoad: data)
        if self.ca_data == nil {
            self.ca_data = data
        }else {
            self.ca_data!.append(data)
        }
    }
    
    func connection(_ connection: NSURLConnection, willCacheResponse cachedResponse: CachedURLResponse) -> CachedURLResponse? {
        return cachedResponse
    }
    
    func connectionDidFinishLoading(_ connection: NSURLConnection) {
        self.client?.urlProtocolDidFinishLoading(self)
    }
}
