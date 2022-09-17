//
//  UIColor+Ext.swift
//  FileBrowser
//
//  Created by Lision, Alexandre on 10/3/19.
//  Copyright © 2019 Roy Marmelstein. All rights reserved.
//

import UIKit

extension UIColor {
    class func fileBrowserBackground() -> UIColor {
        if #available(iOS 13, *) {
            return .systemBackground
        } else {
            return .white
        }
    }
}
