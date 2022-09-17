//
//  Network.swift
//  Pods
//
//  Created by zixun on 17/1/20.
//
//

import Foundation
import CoreTelephony

open class Network: NSObject {
    
    //--------------------------------------------------------------------------
    // MARK: OPEN PROPERTY
    //--------------------------------------------------------------------------
    
    //--------------------------------------------------------------------------
    // MARK: CTCarrier
    //--------------------------------------------------------------------------
    
    /// mobile carrier name
    open static var carrierName: String? {
        get {
            return self.carrier?.carrierName
        }
    }
    
    /// mobile carrier country
    open static var carrierCountry: String? {
        get {
            let currentCountry = Locale.current as NSLocale
            return currentCountry.object(forKey: NSLocale.Key.countryCode) as? String
        }
    }
    
    /// mobile carrier country code
    open static var carrierMobileCountryCode: String? {
        get {
            return self.carrier?.mobileCountryCode
        }
    }
    
    /// get the carrier iso country code
    open static var carrierISOCountryCode: String? {
        get {
            return self.carrier?.isoCountryCode
        }
    }
    /// get the carrier mobile network code
    open static var carrierMobileNetworkCode: String? {
        get {
            return self.carrier?.mobileNetworkCode
        }
    }
    
    open static var carrierAllowVOIP: Bool {
        get {
            return self.carrier?.allowsVOIP ?? false
        }
    }
    
    //--------------------------------------------------------------------------
    // MARK: WIFI
    //--------------------------------------------------------------------------
    
    open static var isConnectedToWifi: Bool {
        get {
            guard let address = self.wifiIPAddress else {
                return false
            }
            
            guard address.characters.count <= 0 else {
                return false
            }
            
            return true
        }
    }
    
    open static var wifiIPAddress: String? {
        get {
           return NetObjc.wifiIPAddress()
        }
    }
    
    open static var wifiNetmaskAddress: String? {
        get {
            return NetObjc.wifiNetmaskAddress()
        }
    }
    
    //--------------------------------------------------------------------------
    // MARK: CELL
    //--------------------------------------------------------------------------
    
    open static var isConnectedToCell: Bool {
        get {
            guard let address = self.cellIPAddress else {
                return false
            }
            
            guard address.characters.count <= 0 else {
                return false
            }
            
            return true
        }
    }
    
    open static var cellIPAddress: String? {
        get {
            return NetObjc.cellIPAddress()
        }
    }
    
    open static var cellNetmaskAddress: String? {
        get {
            return NetObjc.cellNetmaskAddress()
        }
    }
    //--------------------------------------------------------------------------
    // MARK: NETWORK FLOW
    //--------------------------------------------------------------------------
    open static func flow() -> (wifiSend: UInt32,
                            wifiReceived: UInt32,
                                wwanSend: UInt32,
                            wwanReceived: UInt32) {
        let flow = NetObjc.flow()
        return (flow.wifiSend,flow.wifiReceived,flow.wwanSend,flow.wwanReceived)
    }
    
    //--------------------------------------------------------------------------
    // MARK: PRIVATE PROPERTY
    //--------------------------------------------------------------------------
    private static var carrier: CTCarrier? {
        get {
            return CTTelephonyNetworkInfo().subscriberCellularProvider
        }
    }
    
}
