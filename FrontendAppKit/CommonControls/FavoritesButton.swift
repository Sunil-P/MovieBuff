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

        isOn = false
        updateImage()
        addTarget(self, action: #selector(btnClicked(_:)), for: .touchUpInside)
    }

    override func awakeFromNib() {

        super.awakeFromNib()
        isOn = false
        updateImage()
        addTarget(self, action: #selector(btnClicked(_:)), for: .touchUpInside)
    }

    required init?(coder decoder: NSCoder) {

        super.init(coder: decoder)
    }


    var isOn: Bool = false {

        didSet {

            updateImage()
        }
    }
    var forceDarkTheme = false

    @objc func btnClicked (_ sender:UIButton) {

        if sender == self {

            isOn.toggle()
        }
    }

    // MARK: Privates:

    private func updateImage() {

        typealias ImageAsset = Styles.Images

        self.setImage(isOn ? Styles.Images.Favorites.on : Styles.Images.Favorites.off, for: .normal)
    }

} // FavoritesButton
