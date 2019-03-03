//
//  String+.swift
//  Pods
//
//  Created by zixun on 17/1/11.
//
//

import Foundation

extension String {
    
    func date(with dateFormat:String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        return formatter.date(from: self)
    }
}
