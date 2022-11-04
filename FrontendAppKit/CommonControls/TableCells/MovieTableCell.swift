//
//  Home_StaffPickTableCell.swift
//  FrontendAppKit
//
//  Created by Subhrajyoti Patra on 10/29/22.
//

import UIKit

class MovieTableCell: UITableViewCell {

    @IBOutlet weak var moviePosterView: CustomImageView!
    @IBOutlet weak var favoritesButton: FavoritesButton!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var starsLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        releaseDateLabel.text = "ASDASD"
        titleLabel.text = "ASDASD"
        moviePosterView.image = UIImage(named: "samplePoster", in: Styles.frontendAppKitBundle, with: .none)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

} // Home_StaffPickCell
