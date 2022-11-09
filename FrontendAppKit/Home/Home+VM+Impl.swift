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
        }

        static func create(

            with resolver: Resolver

        ) -> Interface {

            resolver.resolve(Interface.self)!
        }

    } // Factory

    final class Impl: Interface {

        init(with resolver: Resolver, scheduler: SchedulerType) {

            self.model = Movie.Manager.Factory.create(with: resolver)
        }

        // MARK: Interface:

        var favoriteMovies: Observable<[Movie.VM.Interface]> {

            model.favoriteMovieVMs

                .map {

                    $0.values.sorted { lhs, rhs in

                        lhs.title < rhs.title
                    }
                }
        }

        var staffPickMovies: Observable<[Movie.VM.Interface]> {

            model.staffPickMovieVMs

                .map {

                    $0.values.sorted { lhs, rhs in

                        lhs.title < rhs.title
                    }
                }
        }

        func refreshAvailableMovies() -> Completable {

            model.refreshAvailableMovies()
        }

        // MARK: Privates:

        private let model: Movie.Manager.Interface

    } // Impl

} // Home.VM
