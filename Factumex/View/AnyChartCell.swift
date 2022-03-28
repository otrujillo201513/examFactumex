//
//  AnyChartCell.swift
//  Factumex
//
//  Created by Macbook on 26/03/22.
//

import UIKit

class AnyChartCell: UITableViewCell {

    @IBOutlet weak var question1: UIButton!
    @IBOutlet weak var question2: UIButton!
    @IBOutlet weak var question3: UIButton!
    @IBOutlet weak var question4: UIButton!
    @IBOutlet weak var question5: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
