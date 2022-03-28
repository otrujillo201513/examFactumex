//
//  TextFieldCell.swift
//  Factumex
//
//  Created by Macbook on 26/03/22.
//

import UIKit

protocol TextFieldCellDelegate: AnyObject {
    func textDidChanged(_ textField: UITextField)
}

class TextFieldCell: UITableViewCell {
    
    @IBOutlet weak var txtUserName: UITextField!
    weak var textFieldDelegate: TextFieldCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        txtUserName.backgroundColor = .gray.withAlphaComponent(0.6)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
