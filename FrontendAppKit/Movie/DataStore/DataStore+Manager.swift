//
//  DataStore+Manager.swift
//  FrontendAppKit
//
//  Created by Subhrajyoti Patra on 11/6/22.
//

import RxSwift

protocol DataStore_Manager_Interface {

    var favoritedMovieIds: Observable<Set<Int>> { get }
    var staffPickMovieIds: Observable<Set<Int>> { get }
    var availableMovies: Observable<[Int: Movie]> { get }

    func updateFavoriteMovie(id: Int)
    func refreshAvailableMovies() -> Completable

} // DataStore_Manager_Interface

extension DataStore {

    struct Manager {

        enum DataStoreError: Error {

            case unableToParse
            case httpRequestFailure
        }

        typealias Interface = DataStore_Manager_Interface

    } // Manager

} // DataStore
