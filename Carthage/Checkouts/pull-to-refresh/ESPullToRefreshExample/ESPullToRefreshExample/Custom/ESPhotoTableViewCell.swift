//
//  ESPhotoTableViewCell.swift
//  ESPullToRefreshExample
//
//  Created by lihao on 2016/11/9.
//  Copyright © 2016年 egg swift. All rights reserved.
//

import UIKit

class ESPhotoTableViewCell: UITableViewCell {

    @IBOutlet weak var indexLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func updateContent(indexPath: IndexPath) {
        let name = String.init(format: "Photo_Lofter_%d", (indexPath.row) % 9 + 1)
        self.photoImageView.image = UIImage.init(named: name)
        self.indexLabel.text = String.init(format: "Section: %d Row: %d", indexPath.section, indexPath.row)
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        self.photoImageView.alpha = highlighted ? 0.8 : 1.0
    }
    
}
