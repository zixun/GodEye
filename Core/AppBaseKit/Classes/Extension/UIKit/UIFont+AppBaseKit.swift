//
//  UIFont+AppBaseKit.swift
//  Pods
//
//  Created by zixun on 2016/10/29.
//
//

import Foundation
import UIKit

extension UIFont {
    
    class func printAllNames() {
        let familyNames = UIFont.familyNames
        
        for familyName in familyNames {
            print("-------\(familyName)-------")
            let fontNames = UIFont.fontNames(forFamilyName: familyName)
            for fontName in fontNames {
                print(fontName)
            }
        }
    }
}
