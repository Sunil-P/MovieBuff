//
//  Home+VM+Impl.swift
//  FrontendAppKit
//
//  Created by Subhrajyoti Patra on 11/6/22.
//

import RxCocoa
import RxSwift
import Swinject

extension Home.VM {

    public struct Factory {

        public static func register(

            with container: Container,
            scheduler: SchedulerType?

        ) {

            container.register(

                Interface.self

            ) { _ in

                Impl(

                    with: container.synchronize(),
                    scheduler: scheduler ?? MainScheduler.instance
                )
            }
            .inObjectScope(.transient)
        }

        static func create(

            with resolver: Resolver

        ) -> Interface {

            resolver.resolve(Interface.self)!
        }

    } // Factory

    final class Impl: Interface {

        init(with resolver: Resolver, scheduler: SchedulerType) {

            self.model = DataStore.Manager.Factory.create(with: resolver)
        }

        // MARK: Interface:

        var favoritedMovieIds: Driver<Set<Int>> {

            model.favoritedMovieIds.asDriver(onErrorDriveWith: .never())
        }

        var staffPickMovieIds: Driver<Set<Int>> {

            model.staffPickMovieIds.asDriver(onErrorDriveWith: .never())
        }

        var availableMovies: Driver<[Int : Movie]> {

            model.availableMovies.asDriver(onErrorDriveWith: .never())
        }

        func updateFavoriteMovie(id: Int) {

            model.updateFavoriteMovie(id: id)
        }

        func refreshAvailableMovies() -> Completable {

            model.refreshAvailableMovies()
        }

        // MARK: Privates:

        private let model: DataStore.Manager.Interface

    } // Impl

} // Home.VM
