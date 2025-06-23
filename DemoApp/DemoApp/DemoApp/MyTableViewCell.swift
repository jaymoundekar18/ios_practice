//
//  MyTableViewCell.swift
//  DemoApp
//
//  Created by Chandra Hasan on 09/06/25.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    @IBOutlet var myLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
