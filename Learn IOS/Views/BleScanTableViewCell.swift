//
//  BleScanTableViewCell.swift
//  Learn IOS
//
//  Created by Kevin Le on 2020/3/10.
//  Copyright © 2020 Kevin Le. All rights reserved.
//

import UIKit

class BleScanTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
