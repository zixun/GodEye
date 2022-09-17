//
//  SizeConverter.swift
//  FileBrowser
//
//  Created by Alexandre Lision on 2018-10-18.
//

import Foundation

func convertSizeToReadableString(with size: UInt64) -> String {
    var convertedValue: Double = Double(size)
    var multiplyFactor = 0
    let tokens = ["bytes", "KB", "MB", "GB", "TB", "PB",  "EB",  "ZB", "YB"]
    while convertedValue > 1024 {
        convertedValue /= 1024
        multiplyFactor += 1
    }
    return String(format: "%4.2f %@", convertedValue, tokens[multiplyFactor])
}
