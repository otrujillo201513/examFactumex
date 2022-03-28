//
//  ButtonCell.swift
//  Factumex
//
//  Created by Macbook on 26/03/22.
//

import UIKit

class ButtonCell: UITableViewCell {
    
    @IBOutlet weak var btnCamera: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
