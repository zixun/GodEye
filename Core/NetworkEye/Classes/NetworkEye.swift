//
//  NetworkEye.swift
//  Pods
//
//  Created by zixun on 16/12/26.
//
//

import Foundation

public protocol NetworkEyeDelegate: NSObjectProtocol {
    func networkEyeDidCatch(with request:URLRequest?,response:URLResponse?,data:Data?)
}

class WeakNetworkEyeDelegate: NSObject {
    weak var delegate : NetworkEyeDelegate?
    init (delegate: NetworkEyeDelegate) {
        super.init()
        self.delegate = delegate
    }
}


open class NetworkEye: NSObject {
    
    public static var isWatching: Bool  {
        get {
            return EyeProtocol.delegates.count > 0
        }
    }
    
    public class func add(observer:NetworkEyeDelegate) {
        if EyeProtocol.delegates.count == 0 {
            EyeProtocol.open()
            URLSession.open()
        }
        EyeProtocol.add(delegate: observer)
    }
    
    public class func remove(observer:NetworkEyeDelegate) {
        EyeProtocol.remove(delegate: observer)
        if EyeProtocol.delegates.count == 0 {
            EyeProtocol.close()
            URLSession.close()
        }
    }
    
}
