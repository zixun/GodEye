//
//  UITableView+.swift
//  Pods
//
//  Created by zixun on 17/1/4.
//
//

import Foundation

extension UITableView {
    func dequeueReusableCell<E: UITableViewCell>(style:UITableViewCellStyle = UITableViewCellStyle.default,
                             identifier:String = E.identifier(),
                             _ configure: (E) -> Void) -> E {
        var cell = self.dequeueReusableCell(withIdentifier: identifier) as? E
        if cell == nil {
            cell = E(style: style, reuseIdentifier: identifier)
            configure(cell!)
        }
        return cell!
    }
}
