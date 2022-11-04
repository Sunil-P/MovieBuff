//
//  Styles.swift
//  FrontendAppKit
//
//  Created by Subhrajyoti Patra on 10/29/22.
//

import UIKit

struct Styles {

    struct ColorIds {

        static let highEmphasis = UIColor(

            named: "highEmphasis",
            in: frontendAppKitBundle,
            compatibleWith: .none
        )!
        static let lowEmphasis = UIColor(

            named: "lowEmphasis",
            in: frontendAppKitBundle,
            compatibleWith: .none
        )!
        static let lowEmphasisLight = UIColor(

            named: "lowEmphasis.light",
            in: frontendAppKitBundle,
            compatibleWith: .none

        )!
        static let veryLowEmphasisPill = UIColor(

            named: "veryLowEmphasisPill",
            in: Styles.frontendAppKitBundle,
            compatibleWith: .none
        )

    } // ColorIds

    struct Images {

        static let onImage = UIImage(named: "favoritesButton.on", in: Styles.frontendAppKitBundle, with: .none)
        static let searchBtnImage = UIImage(named: "favorites.on", in: Styles.frontendAppKitBundle, with: .none)
        static let offImage = UIImage(named: "favoritesButton.off", in: Styles.frontendAppKitBundle, with: .none)

    } // Images

    static let frontendAppKitBundle = Bundle(identifier: "spatra.FrontendAppKit")

} // Styles
