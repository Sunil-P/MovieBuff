//
//  RatingView.swift
//  FrontendAppKit
//
//  Created by Subhrajyoti Patra on 10/30/22.
//

import UIKit

@IBDesignable
class RatingView: UIView {

    @IBInspectable var starSize: Int = 10 {

        didSet {

            refreshStackView()
        }
    }

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

    override init(frame: CGRect) {

        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {

        super.init(coder: coder)
        setup()
    }

    // MARK: Privates:

    private let starImage = (

        filled: UIImage(named: "star.filled", in: Styles.frontendAppKitBundle, with: .none),
        empty: UIImage(named: "star.empty", in: Styles.frontendAppKitBundle, with: .none)
    )

    private var internalRating = 0 {

        didSet {

            refreshStackView()
        }
    }
    private var stackView: UIStackView!

    private func setup() {

        stackView = UIStackView()

        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .leading
        stackView.spacing = 2

        self.addSubview(stackView)
        refreshStackView()
    }

    private func refreshStackView() {

        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        let starSizeFloat = CGFloat(starSize)
        let emptyStarsCount = 5 - internalRating

        (0..<internalRating).forEach { _ in

            let imageView = UIImageView(image: starImage.filled)
            imageView.heightAnchor.constraint(equalToConstant: starSizeFloat).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: starSizeFloat).isActive = true

            stackView.addArrangedSubview(imageView)
        }

        (0..<emptyStarsCount).forEach { _ in

            let imageView = UIImageView(image: starImage.empty)
            imageView.heightAnchor.constraint(equalToConstant: starSizeFloat).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: starSizeFloat).isActive = true

            stackView.addArrangedSubview(imageView)
        }

        stackView.translatesAutoresizingMaskIntoConstraints = false

        stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}
