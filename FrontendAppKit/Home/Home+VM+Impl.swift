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

            print("Home.VM constructing...")

            self.model = Movie.Manager.Factory.create(with: resolver)

            print("Home.VM has been constructed.")
        }

        deinit {

            print("~Home.VM has been destructed.")
        }

        // MARK: Interface:

        var tableViewSections: Observable<[Home.RowSection]> {

            staffPickMovies

                .map { staffPickMovieVMs in

                    let staffPickMovieRowItems = staffPickMovieVMs.map { movieVM in

                        return Home.StaffPickMovieRowItem(movieVM: movieVM)
                    }

                    return [

                        Home.RowSection(items: [Home.SearchRowItem()]),
                        Home.RowSection(items: [Home.FavoriteMovieRowItem()]),
                        Home.RowSection(items: staffPickMovieRowItems)
                    ]
                }
        }

        var collectionCellVMs: Observable<[CollectionCellVM]> {

            favoriteMovies

                .map {

                    var result: [CollectionCellVM] = $0.prefix(3).map { movieVM in

                        MovieCollectionCellVM(movie: movieVM)
                    }

                    if $0.count > 3 {

                        result.append(SeeAllCellVM())
                    }

                    return result
                }
        }

        func refreshAvailableMovies() -> Completable {

            model.refreshAvailableMovies()
        }

        // MARK: Privates:

        private let model: Movie.Manager.Interface

        private var favoriteMovies: Observable<[Movie.VM.Interface]> {

            model.favoriteMovieVMs

                .map {

                    $0.values.sorted { lhs, rhs in

                        lhs.title < rhs.title
                    }
                }
        }

        private var staffPickMovies: Observable<[Movie.VM.Interface]> {

            model.staffPickMovieVMs

                .map {

                    $0.values.sorted { lhs, rhs in

                        lhs.title < rhs.title
                    }
                }
        }

    } // Impl

} // Home.VM
