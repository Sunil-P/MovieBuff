//
//  Home_StaffPickTableCell.swift
//  FrontendAppKit
//
//  Created by Subhrajyoti Patra on 10/29/22.
//

import UIKit

class MovieTableCell: UITableViewCell {

    @IBOutlet weak var moviePosterView: CustomImageView!
    @IBOutlet weak var ratingView: RatingView!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        ratingView.alignment = .leading
        moviePosterView.image = UIImage(named: "samplePoster", in: Styles.frontendAppKitBundle, with: .none)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

} // Home_StaffPickCell
