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
        static let highEmphasisLight = UIColor(

            named: "highEmphasis.light",
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
        )!

    } // ColorIds

    struct Images {

        struct Favorites {

            static let on = (

                light: UIImage(named: "favoritesButton.on.light", in: Styles.frontendAppKitBundle, with: .none)!,
                dark: UIImage(named: "favoritesButton.on.dark", in: Styles.frontendAppKitBundle, with: .none)!
            )

            static let off = (

                light: UIImage(named: "favoritesButton.off.light", in: Styles.frontendAppKitBundle, with: .none)!,
                dark: UIImage(named: "favoritesButton.off.dark", in: Styles.frontendAppKitBundle, with: .none)!
            )

        } // Favorites

        struct Star {

            static let empty = (

                light: UIImage(named: "star.empty.light", in: Styles.frontendAppKitBundle, with: .none)!,
                dark: UIImage(named: "star.empty.dark", in: Styles.frontendAppKitBundle, with: .none)!
            )
            static let filled = UIImage(named: "star.filled", in: Styles.frontendAppKitBundle, with: .none)!
            static let white = UIImage(named: "star.white", in: Styles.frontendAppKitBundle, with: .none)!

        } // Star

        static let searchBtnImage = UIImage(named: "favorites.on", in: Styles.frontendAppKitBundle, with: .none)!

    } // Images

    struct AttributedTypography {

        static let regularTypographyLight = [

            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .medium),
            NSAttributedString.Key.foregroundColor: Styles.ColorIds.highEmphasis
        ]
        static let boldTypographyLight = [

            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .heavy),
            NSAttributedString.Key.foregroundColor: Styles.ColorIds.highEmphasis
        ]
        static let regularTypographyDark = [

            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .medium),
            NSAttributedString.Key.foregroundColor: Styles.ColorIds.highEmphasisLight
        ]
        static let boldTypographyDark = [

            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .heavy),
            NSAttributedString.Key.foregroundColor: Styles.ColorIds.highEmphasisLight
        ]
    }

    static let frontendAppKitBundle = Bundle(identifier: "spatra.FrontendAppKit")

} // Styles
