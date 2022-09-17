//
//  UITableViewCell+.swift
//  Pods
//
//  Created by zixun on 17/1/4.
//
//

import Foundation

extension UITableViewCell {
    class func identifier() -> String {
        return NSStringFromClass(self.classForCoder())
    }
}
