//
//  RatingButtonView.swift
//  FrontendAppKit
//
//  Created by Subhrajyoti Patra on 11/3/22.
//

import UIKit

@IBDesignable
class RatingButtonView: UIButton {

    @IBInspectable var rating: Int {

        set(newValue) {

            if newValue >= 0 && newValue <= 5 {

                internalRating = newValue
            }
        }
        get {

            internalRating
        }
    }

    @IBInspectable var isOn: Bool = false {

        didSet {

            refreshImages()
        }
    }

    override init(frame: CGRect) {

        super.init(frame: frame)
        setupButton()
    }

    required init?(coder: NSCoder) {

        super.init(coder: coder)
        setupButton()
    }

    override func layoutSubviews() {

        super.layoutSubviews()
    }

    // MARK: Privates:

    private let starImage = (

        white: UIImage(named: "star.white", in: Styles.frontendAppKitBundle, with: .none),
        filled: UIImage(named: "star.filled", in: Styles.frontendAppKitBundle, with: .none)
    )
    private var internalRating = 0 {

        didSet {

            refreshImages()
        }
    }

    private func setupButton() {

        layer.cornerRadius = 15
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.cgColor

        refreshImages()
    }

    private func refreshImages() {

        let image = isOn ? starImage.filled : starImage.white

        let paddingX = 16
        let marginX = 2
        let marginY = 10

        let imageWidth = 10
        let imageHeight = 10

        let width = CGFloat(rating * imageWidth + (rating - 1) * marginX + paddingX * 2)
        let height = CGFloat(imageHeight + marginY + marginY)
        var imageXPos = paddingX
        let imageYPos = marginY

        for _ in 0..<rating {

            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFill
            imageView.frame = .init(x: imageXPos, y: imageYPos, width: imageWidth, height: imageHeight)

            imageXPos = imageXPos + imageWidth + marginX
            addSubview(imageView)
        }

        constraints.forEach {

            removeConstraint($0)
        }
        widthAnchor.constraint(equalToConstant: width).isActive = true
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
}
