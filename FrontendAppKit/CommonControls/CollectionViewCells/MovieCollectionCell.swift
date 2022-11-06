//
//  MovieCollectionCell.swift
//  FrontendAppKit
//
//  Created by Subhrajyoti Patra on 10/29/22.
//

import UIKit

class MovieCollectionCell: UICollectionViewCell {

    @IBOutlet weak var cellButton: UIButton!

    override func awakeFromNib() {

        super.awakeFromNib()

        self.layer.masksToBounds = true
        self.clipsToBounds = false

        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 10

        cellButton.imageView?.contentMode = .scaleAspectFit;

        cellButton.clipsToBounds = true
        cellButton.layer.cornerRadius = 14
    }

} // MovieCollectionCell
