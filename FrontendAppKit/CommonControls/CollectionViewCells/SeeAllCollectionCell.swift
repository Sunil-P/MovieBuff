//
//  SeeAllCollectionCell.swift
//  FrontendAppKit
//
//  Created by Subhrajyoti Patra on 11/6/22.
//

import UIKit

class SeeAllCollectionCell: UICollectionViewCell {

    @IBOutlet weak var cellButton: UIButton!

    @IBAction func handleCellButtonAction(_ sender: Any) {

        cellButtonClicked?()
    }

    var cellButtonClicked: (() -> ())?

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

} // SeeAllCollectionCell
