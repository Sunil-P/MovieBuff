//
//  KeyfactView.swift
//  FrontendAppKit
//
//  Created by Subhrajyoti Patra on 10/30/22.
//

import UIKit

@IBDesignable final class KeyfactView: UIView {

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

    // MARK: Privates:

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
        self.layer.backgroundColor = Styles.ColorIds.veryLowEmphasisPill.cgColor
    }

    private func refreshStackView() {

        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        if !key.isEmpty {

            let keyLabel = UILabel()
            keyLabel.text = key
            keyLabel.numberOfLines = 2
            keyLabel.textColor = Styles.ColorIds.highEmphasis
            keyLabel.font = UIFont.systemFont(ofSize: 12, weight: .heavy)

            stackView.addArrangedSubview(keyLabel)
        }

        if !fact.isEmpty {

            let factLabel = UILabel()
            factLabel.text = fact
            factLabel.textColor = .black
            factLabel.numberOfLines = 2
            factLabel.font = UIFont.systemFont(ofSize: 16, weight: .light)

            stackView.addArrangedSubview(factLabel)
        }

        stackView.translatesAutoresizingMaskIntoConstraints = false

        stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        stackView.topAnchor.constraint(equalTo: topAnchor, constant: 12).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12).isActive = true
    }

} // KeyfactView
