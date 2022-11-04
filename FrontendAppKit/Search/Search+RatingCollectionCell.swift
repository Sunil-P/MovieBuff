//
//  Search+RatingCollectionCell.swift
//  FrontendAppKit
//
//  Created by Subhrajyoti Patra on 11/3/22.
//

import UIKit

class Search_RatingCollectionCell: UICollectionViewCell {

    @IBOutlet weak var ratingButton: RatingButtonView!

    var handleAction: (()->())?

    @IBAction func ratingButtonAction(_ sender: RatingButtonView) {

        handleAction?()
    }

    override func awakeFromNib() {

        super.awakeFromNib()
    }
}
