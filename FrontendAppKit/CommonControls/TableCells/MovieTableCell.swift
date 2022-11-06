//
//  MovieTableCell.swift
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
    @IBOutlet weak var favoritesButton: FavoritesButton!
    
    override func awakeFromNib() {

        super.awakeFromNib()

        ratingView.alignment = .leading
        moviePosterView.image = UIImage(named: "samplePoster", in: Styles.frontendAppKitBundle, with: .none)

        favoritesButton.overriddenTheme = .dark
        ratingView.overriddenTheme = .dark
    }

} // MovieTableCell
