//
//  CustomImageView.swift
//  FrontendAppKit
//
//  Created by Subhrajyoti Patra on 10/30/22.
//

import UIKit

@IBDesignable
class CustomImageView: UIView {

    override init(frame: CGRect) {

        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {

        super.init(coder: coder)
        setup()
    }

    // MARK: IBInspectable:

    @IBInspectable var image: UIImage? = nil {

        didSet {

            imageLayer.contents = image?.cgImage
            shadowLayer.shadowPath = (image == nil) ? nil : shapeAsPath
        }
    }

    @IBInspectable var title: String = "" {

        didSet {

            guard !title.isEmpty else {

                titleLabel.removeFromSuperview()
                stackView.removeArrangedSubview(titleLabel)
                return
            }

            titleLabel.text = title
            stackView.insertArrangedSubview(titleLabel, at: 0)
        }
    }

    @IBInspectable var subtitle = "" {

        didSet {

            guard !subtitle.isEmpty else {

                subtitleLabel.removeFromSuperview()
                stackView.removeArrangedSubview(subtitleLabel)
                return
            }

            subtitleLabel.text = subtitle
            stackView.addArrangedSubview(subtitleLabel)
        }
    }

    override func layoutSubviews() {

        super.layoutSubviews()

        clipsToBounds = false
        backgroundColor = .clear

        self.layer.addSublayer(shadowLayer)
        self.layer.addSublayer(imageLayer)

        if !title.isEmpty || !subtitle.isEmpty {

            self.layer.addSublayer(createGradientLayer())
        }
        self.addSubview(stackView)

        // Image layer
        imageLayer.frame = bounds
        imageLayer.contentsGravity = .resizeAspectFill
        imageLayer.mask = shapeAsMask

        // Shadow layer
        shadowLayer.shadowPath = (image == nil) ? nil : shapeAsPath
        shadowLayer.shadowOpacity = 0.5
        shadowLayer.shadowRadius = 10
        shadowLayer.shadowColor = UIColor.black.cgColor
        shadowLayer.shadowOffset = .init(width: 0, height: 0)

        // Stack view
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
    }

    // MARK: Privates:

    private let imageLayer = CALayer()
    private let shadowLayer = CALayer()

    private var shape: UIBezierPath {

        UIBezierPath(roundedRect: bounds, cornerRadius: 14)
    }
    private var shapeAsPath: CGPath {

        shape.cgPath
    }
    private var shapeAsMask: CAShapeLayer {

        let mask = CAShapeLayer()
        mask.path = shapeAsPath
        return mask
    }
    private var titleLabel: UILabel!
    private var subtitleLabel: UILabel!
    private var stackView: UIStackView!
    private var gradientView: UIView!

    private func setup() {

        stackView = UIStackView()
        titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 12, weight: .bold)
        titleLabel.numberOfLines = 0
        titleLabel.textColor = .white

        subtitleLabel = UILabel()
        subtitleLabel.font = .systemFont(ofSize: 12, weight: .light)
        subtitleLabel.numberOfLines = 0
        subtitleLabel.textColor = .white

        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .leading
        stackView.spacing = 2
    }

    private func createGradientLayer() -> CAGradientLayer {

        let gradientLayer = CAGradientLayer()

        let gradientHeight = bounds.height * 4/9
        let gradientY = bounds.height - gradientHeight

        gradientLayer.frame = .init(x: bounds.origin.x, y: gradientY, width: bounds.width, height: gradientHeight)
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]

        let shape = CAShapeLayer()
        shape.path = UIBezierPath(roundedRect: gradientLayer.bounds, cornerRadius: 14).cgPath
        gradientLayer.mask = shape

        return gradientLayer
    }
}
