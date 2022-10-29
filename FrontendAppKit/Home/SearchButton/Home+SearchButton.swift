//
//  Home+SearchButton.swift
//  FrontendAppKit
//
//  Created by Subhrajyoti Patra on 10/29/22.
//

import UIKit

extension Home {

    class SearchButton: UIButton {

        override init(frame: CGRect) {

            super.init(frame: frame)

            updateImage()
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

        private typealias ImageAsset = Styles.FavoritesButton

        private func updateImage() {

            self.setImage(isOn ? ImageAsset.onImage : ImageAsset.offImage, for: .normal)
        }
    }

} // Home
