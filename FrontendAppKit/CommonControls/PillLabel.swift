//
//  PillLabel.swift
//  FrontendAppKit
//
//  Created by Subhrajyoti Patra on 11/2/22.
//

import UIKit

class PillLabel: UILabel {

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    init(title: String) {

        super.init(frame: CGRect.zero)
        self.text = title
        setupView()
    }

    override func awakeFromNib() {

        super.awakeFromNib()
        setupView()
    }

    override func drawText(in rect: CGRect) {

        let insets = UIEdgeInsets(top: inset.top, left: inset.leading, bottom: inset.bottom, right: inset.trailing)
        super.drawText(in: rect.inset(by: insets))
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + inset.leading + inset.trailing,
                      height: size.height + inset.top + inset.bottom)
    }

    override var bounds: CGRect {
        didSet {

            // ensures this works within stack views if multi-line
            preferredMaxLayoutWidth = bounds.width - (inset.leading + inset.trailing)
        }
    }

    // MARK: Privates:

    private let inset = (

        top: CGFloat(2),
        bottom: CGFloat(2),
        leading: CGFloat(8),
        trailing: CGFloat(8)
    )

    private func setupView() {

        self.layer.masksToBounds = true
        self.layer.cornerRadius = 11
        backgroundColor =  Styles.ColorIds.veryLowEmphasisPill
        self.font = .systemFont(ofSize: 16, weight: .light)
        self.textColor = .black
    }
}
