//
//  CustomImageButtonView.swift
//  FrontendAppKit
//
//  Created by Subhrajyoti Patra on 10/30/22.
//

import UIKit

@IBDesignable
class CustomImageButtonView: UIButton {

    override func awakeFromNib() {

        super.awakeFromNib()
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 14
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 10
    }
}
