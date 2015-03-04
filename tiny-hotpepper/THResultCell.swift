//
//  THResultCell.swift
//  tiny-hotpepper
//
//  Created by ishimaru on 2015/03/03.
//  Copyright (c) 2015 shoya140. All rights reserved.
//

import UIKit

class THResultCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 5.0
        self.clipsToBounds = true
    }
}
