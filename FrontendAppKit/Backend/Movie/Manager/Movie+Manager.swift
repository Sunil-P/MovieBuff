//
//  Movie+Manager.swift
//  FrontendAppKit
//
//  Created by Subhrajyoti Patra on 11/9/22.
//

import RxSwift

protocol Movie_Manager_Interface {

    var allMovieVMs: Observable<[Int: Movie.VM.Interface]> { get }
    var favoriteMovieVMs: Observable<[Int: Movie.VM.Interface]> { get }
    var staffPickMovieVMs: Observable<[Int: Movie.VM.Interface]> { get }

    func refreshAvailableMovies() -> Completable

} // Movie_Manager_Interface

extension Movie {

    struct Manager {

        typealias Interface = Movie_Manager_Interface

    }
}
