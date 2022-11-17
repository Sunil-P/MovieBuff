//
//  RatingCollectionCell.swift
//  FrontendAppKit
//
//  Created by Subhrajyoti Patra on 11/3/22.
//

import UIKit

class RatingCollectionCell: UICollectionViewCell {

    @IBOutlet weak var ratingButton: RatingButtonView!

    var cellButtonClicked: (()->())?

    @IBAction func ratingButtonAction(_ sender: RatingButtonView) {

        cellButtonClicked?()
    }

} // RatingCollectionCell
