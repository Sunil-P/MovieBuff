//
//  Home+Sections.swift
//  FrontendAppKit
//
//  Created by Subhrajyoti Patra on 11/10/22.
//

import RxDataSources

protocol RowItem {}

extension Home {

    struct SearchRowItem: RowItem { }

    struct FavoriteMovieRowItem: RowItem { }

    struct StaffPickMovieRowItem: RowItem {

        var movieVM: Movie.VM.Interface

    } // StaffPickMovieRowItem

    struct RowSection {

        var items: [Item]
    } // RowSection

} // Home

extension Home.RowSection: SectionModelType {

    typealias Item = RowItem

    init(original: Home.RowSection, items: [Item]) {

        self = original
        self.items = items
    }

} // Home.RowSection
