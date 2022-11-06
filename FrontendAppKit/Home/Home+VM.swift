//
//  Home+VM.swift
//  FrontendAppKit
//
//  Created by Subhrajyoti Patra on 11/6/22.
//

import RxCocoa
import RxSwift

protocol Home_ViewModel_Interface {

    var favoritedMovieIds: Driver<Set<Int>> { get }
    var staffPickMovieIds: Driver<Set<Int>> { get }
    var availableMovies: Driver<[Int: Movie]> { get }

    func updateFavoriteMovie(id: Int)
    func refreshAvailableMovies() -> Completable

} // HomeViewModel

extension Home {

    struct VM {

        typealias Interface = Home_ViewModel_Interface

    } // VM

} // Home
