//
//  Home_StaffPickTableCell.swift
//  FrontendAppKit
//
//  Created by Subhrajyoti Patra on 10/29/22.
//

import UIKit

class Home_StaffPickTableCell: UITableViewCell {

    @IBOutlet weak var moviePosterImg: UIImageView!
    @IBOutlet weak var favoritesBtn: UIButton!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var starsLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

} // Home_StaffPickCell
