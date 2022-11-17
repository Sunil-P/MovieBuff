//
//  RatingView.swift
//  FrontendAppKit
//
//  Created by Subhrajyoti Patra on 10/30/22.
//

import UIKit

@IBDesignable class RatingView: UIView, CommonControls {

    override init(frame: CGRect) {

        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {

        super.init(coder: coder)
        setup()
    }

    enum Alignment {

        case leading
        case center
        case trailing
    }

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
    var alignment: Alignment = .center {

        didSet {

            refreshStackView()
        }
    }
    var overriddenTheme: OverriddenTheme = .light {

        didSet {

            refreshStackView()
        }
    }

    // MARK: Privates:

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

        typealias StarAsset = Styles.Images.Star

        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        stackView.constraints.forEach {

            removeConstraint($0)
        }
        constraints.forEach {

            removeConstraint($0)
        }

        let starSizeFloat = CGFloat(starSize)
        let emptyStarsCount = 5 - internalRating

        let image = (

            starFilled: StarAsset.filled,
            starEmpty: overriddenTheme == .light ? StarAsset.empty.light : StarAsset.empty.dark
        )

        (0..<internalRating).forEach { _ in

            let imageView = UIImageView(image: image.starFilled)
            imageView.heightAnchor.constraint(equalToConstant: starSizeFloat).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: starSizeFloat).isActive = true

            stackView.addArrangedSubview(imageView)
        }

        (0..<emptyStarsCount).forEach { _ in

            let imageView = UIImageView(image: image.starEmpty)
            imageView.heightAnchor.constraint(equalToConstant: starSizeFloat).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: starSizeFloat).isActive = true

            stackView.addArrangedSubview(imageView)
        }

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        switch alignment {

        case .leading:

            stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true

        case .center:

            stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true

        case .trailing:

            stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        }
    }

} // RatingView
