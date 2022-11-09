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

    var staffPickMovies: Observable<[Movie.VM.Interface]> { get }
    var favoriteMovies: Observable<[Movie.VM.Interface]> { get }

    func refreshAvailableMovies() -> Completable

} // HomeViewModel

extension Home {

    struct VM {

        typealias Interface = Home_ViewModel_Interface

    } // VM

} // Home
