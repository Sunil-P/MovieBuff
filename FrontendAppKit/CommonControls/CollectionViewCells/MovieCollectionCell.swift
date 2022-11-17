//
//  MovieCollectionCell.swift
//  FrontendAppKit
//
//  Created by Subhrajyoti Patra on 10/29/22.
//

import UIKit

class MovieCollectionCell: UICollectionViewCell {

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

        cellButton.clipsToBounds = true

        cellButton.layer.cornerRadius = 14
    }

    func setupImage(image: UIImage) {

        let targetSize = CGSize(width: cellButton.frame.width, height: cellButton.frame.height)

        // Compute the scaling ratio for the width and height separately
        let widthScaleRatio = targetSize.width / image.size.width
        let heightScaleRatio = targetSize.height / image.size.height

        // To keep the aspect ratio, scale by the smaller scaling ratio
        let scaleFactor = min(widthScaleRatio, heightScaleRatio)

        // Multiply the original image’s dimensions by the scale factor
        // to determine the scaled image size that preserves aspect ratio
        let scaledImageSize = CGSize(
            width: image.size.width * scaleFactor,
            height: image.size.height * scaleFactor
        )

        let renderer = UIGraphicsImageRenderer(size: scaledImageSize)
        let scaledImage = renderer.image { _ in
            image.draw(in: CGRect(origin: .zero, size: scaledImageSize))
        }

        cellButton.setImage(scaledImage, for: .normal)
    }

} // MovieCollectionCell
