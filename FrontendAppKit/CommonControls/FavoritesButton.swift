//
//  FavoritesButton.swift
//  FrontendAppKit
//
//  Created by Subhrajyoti Patra on 10/29/22.
//

import UIKit

@IBDesignable
class FavoritesButton: UIButton {

    override init(frame: CGRect) {

        super.init(frame: frame)

        self.isOn = false
        self.updateImage()
        self.addTarget(self, action: #selector(btnClicked(_:)), for: .touchUpInside)
    }

    override func awakeFromNib() {

        super.awakeFromNib()
        self.isOn = false
        self.updateImage()
        self.addTarget(self, action: #selector(btnClicked(_:)), for: .touchUpInside)
    }

    required init?(coder decoder: NSCoder) {

        super.init(coder: decoder)
    }

    @objc func btnClicked (_ sender:UIButton) {

        if sender == self {

            isOn.toggle()
        }
    }

    var isOn: Bool = false {

        didSet {

            self.updateImage()
        }
    }

    // MARK: Privates:

    private func updateImage() {

        typealias ImageAsset = Styles.Images

        self.setImage(isOn ? ImageAsset.onImage : ImageAsset.offImage, for: .normal)
    }

} // FavoritesButton
