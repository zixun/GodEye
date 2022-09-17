//
//  Date+.swift
//  Pods
//
//  Created by zixun on 17/1/11.
//
//

import Foundation

extension Date {
    func string(with dateFormat:String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        return formatter.string(from: self)
    }
}
