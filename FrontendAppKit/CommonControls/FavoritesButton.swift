//
//  FavoritesButton.swift
//  FrontendAppKit
//
//  Created by Subhrajyoti Patra on 10/29/22.
//

import UIKit

@IBDesignable
class FavoritesButton: UIButton, CommonControls {

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

    @objc func btnClicked (_ sender:UIButton) {

        if sender == self {

            isOn.toggle()
        }
    }

    var overriddenTheme: OverriddenTheme = .light {

        didSet {

            updateImage()
        }
    }

    // MARK: Privates:

    private func updateImage() {

        typealias FavoritesAsset = Styles.Images.Favorites

        let image: UIImage!

        switch (isOn, overriddenTheme) {

        case(true, .light): image = FavoritesAsset.on.light
        case (false, .light): image = FavoritesAsset.off.light
        case (true, .dark): image = FavoritesAsset.on.dark
        case (false, .dark): image = FavoritesAsset.off.dark
        }

        self.setImage(image, for: .normal)
    }

} // FavoritesButton
