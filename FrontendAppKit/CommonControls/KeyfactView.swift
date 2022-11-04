//
//  KeyfactView.swift
//  FrontendAppKit
//
//  Created by Subhrajyoti Patra on 10/30/22.
//

import UIKit

@IBDesignable
class KeyfactView: UIView {

    @IBInspectable var key: String = "" {

        didSet {

            refreshStackView()
        }
    }

    @IBInspectable var fact: String = "" {

        didSet {

            refreshStackView()
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

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self.updateColors()
        self.setNeedsDisplay()
    }

    // MARK: Privates:

    private let color = (

        backgroundColor: UIColor(named: "veryLowEmphasisPill", in: Styles.frontendAppKitBundle, compatibleWith: nil)!,
        tertiaryLabel: UIColor(named: "tertiaryLabel", in: Styles.frontendAppKitBundle, compatibleWith: .none)!,
        factLabel: UIColor(named: "factLabel", in: Styles.frontendAppKitBundle, compatibleWith: .none)!
    )

    private var stackView: UIStackView!

    private func setup() {

        stackView = UIStackView()

        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .leading
        stackView.spacing = 4

        self.addSubview(stackView)

        refreshStackView()

        self.layer.cornerRadius = 14
        self.layer.backgroundColor = color.backgroundColor.cgColor
    }

    private func updateColors() {

        self.layer.backgroundColor = color.backgroundColor.resolvedColor(with: self.traitCollection).cgColor
    }

    private func refreshStackView() {

        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        if !key.isEmpty {

            let keyLabel = UILabel()
            keyLabel.text = key
            keyLabel.textColor = color.tertiaryLabel
            keyLabel.font = UIFont.systemFont(ofSize: 12, weight: .heavy)

            stackView.addArrangedSubview(keyLabel)
        }

        if !fact.isEmpty {

            let factLabel = UILabel()
            factLabel.text = fact
            factLabel.textColor = color.factLabel
            factLabel.numberOfLines = 2
            factLabel.font = UIFont.systemFont(ofSize: 16, weight: .light)

            factLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true

            stackView.addArrangedSubview(factLabel)
        }

        stackView.translatesAutoresizingMaskIntoConstraints = false

        stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }

} // KeyfactView
