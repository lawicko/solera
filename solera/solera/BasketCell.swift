//
//  BasketCell.swift
//  solera
//
//  Created by Jakub Lawicki on 28.04.17.
//  Copyright © 2017 Jakub Lawicki. All rights reserved.
//

import UIKit

class BasketCell: UITableViewCell {
    
    var plusButtonCallback: (()->())?
    var minusButtonCallback: (()->())?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func onPlusButtonTouched(sender: UIButton) {
        if let callback = self.plusButtonCallback {
            callback()
        }
    }
    
    @IBAction func onMinusButtonTouched(sender: UIButton) {
        if let callback = self.minusButtonCallback {
            callback()
        }
    }
}
