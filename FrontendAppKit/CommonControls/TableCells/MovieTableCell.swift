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

    var separatorView = UIView()
    
    override func awakeFromNib() {

        super.awakeFromNib()

        ratingView.alignment = .leading
        ratingView.overriddenTheme = .dark
        favoritesButton.overriddenTheme = .dark

        separatorView.backgroundColor = Styles.ColorIds.lowEmphasisLight
        addSubview(separatorView)
    }

} // MovieTableCell
