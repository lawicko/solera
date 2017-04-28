//
//  ShopViewCell.swift
//  solera
//
//  Created by Jakub Lawicki on 28.04.17.
//  Copyright © 2017 Jakub Lawicki. All rights reserved.
//

import UIKit

class ShopViewCell: UICollectionViewCell {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var itemNameLabel: UILabel!
    @IBOutlet var itemPriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.cornerRadius = 5.0
        self.layer.borderWidth = 1/UIScreen.main.scale
        self.layer.borderColor = UIColor.gray.cgColor
    }
}
