//
//  CommonControls.swift
//  FrontendAppKit
//
//  Created by Subhrajyoti Patra on 11/6/22.
//

protocol CommonControls {

    var overriddenTheme: OverriddenTheme { get set }

} // CommonControls

enum OverriddenTheme {

    case light
    case dark

} // OverriddenTheme
