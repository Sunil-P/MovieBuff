//
//  Home+VM.swift
//  FrontendAppKit
//
//  Created by Subhrajyoti Patra on 11/6/22.
//

import RxCocoa
import RxSwift
import UIKit

protocol Home_ViewModel_Interface {

    var isRefreshing: Observable<Bool> { get }
    var tableViewSections: Observable<[Home.RowSection]> { get }
    var collectionCellVMs: Observable<[CollectionCellVM]> { get }

    func refreshAvailableMovies()

} // Home_ViewModel_Interface

extension Home {

    struct VM {

        typealias Interface = Home_ViewModel_Interface

    } // VM

} // Home
