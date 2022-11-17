//
//  Movie+Manager+Impl.swift
//  FrontendAppKit
//
//  Created by Subhrajyoti Patra on 11/9/22.
//

import RxSwift
import Swinject

extension Movie.Manager {

    struct Factory {

        static func register(

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

            Movie.VM.Factory.register(with: container, scheduler: scheduler)
        }

        static func create(with resolver: Resolver) -> Interface {

            resolver.resolve(Interface.self)!
        }

    } // Factory

    // MARK: -

    class Impl: Interface {

        init(with resolver: Resolver, scheduler: SchedulerType) {

            print("Movie.Manager constructing...")

            self.resolver = resolver
            self.dataStoreManager = DataStore.Manager.Factory.create(with: resolver)

            print("Movie.Manager has been constructed.")
        }

        deinit {

            print("~Movie.Manager has been destructed.")
        }

        // MARK: Interface:

        var allMovieVMs: Observable<[Int: Movie.VM.Interface]> {

            dataStoreManager.availableMovies

                .map { [resolver] in

                    $0.mapValues { model in

                        Movie.VM.Factory.create(with: resolver, spec: .init(movieModel: model))
                    }
                }
        }

        var favoriteMovieVMs: Observable<[Int : Movie.VM.Interface]> {

            Observable.combineLatest(

                dataStoreManager.availableMovies,
                dataStoreManager.favoritedMovieIds
            )
            .map { [resolver] availableMovies, favoriteMovieIds in

                availableMovies.compactMapValues { model in

                    guard favoriteMovieIds.contains(model.id) else {

                        return nil
                    }

                    return Movie.VM.Factory.create(with: resolver, spec: .init(movieModel: model))
                }
            }
        }

        var staffPickMovieVMs: Observable<[Int : Movie.VM.Interface]> {

            Observable.combineLatest(

                dataStoreManager.availableMovies,
                dataStoreManager.staffPickMovieIds
            )
            .map { [resolver] availableMovies, staffPickMovieIds in

                availableMovies.compactMapValues { model in

                    guard staffPickMovieIds.contains(model.id) else {

                        return nil
                    }

                    return Movie.VM.Factory.create(with: resolver, spec: .init(movieModel: model))
                }
            }
        }

        func refreshAvailableMovies() -> Completable {

            dataStoreManager.refreshAvailableMovies()
        }

        // MARK: Privates:

        private let resolver: Resolver
        private let dataStoreManager: DataStore.Manager.Interface
    }

} // Movie.Manager
