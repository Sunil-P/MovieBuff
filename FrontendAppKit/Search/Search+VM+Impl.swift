//
//  Search+VM+Impl.swift
//  FrontendAppKit
//
//  Created by Subhrajyoti Patra on 11/16/22.
//

import RxRelay
import RxSwift
import Swinject

extension Search.VM {

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

            print("Search.VM constructing...")

            self.model = Movie.Manager.Factory.create(with: resolver)

            print("Search.VM has been constructed.")
        }

        deinit {

            print("~Search.VM has been destructed.")
        }

        // MARK: Interface:

        var isRefreshing: Observable<Bool> {

            refreshRelay.asObservable()
        }

        var movieVMs: Observable<[Movie.VM.Interface]> {

            Observable.combineLatest(

                model.allMovieVMs,
                filterRelay.text.asObservable(),
                filterRelay.rating.asObservable()
            )
            .map { allMovieVMs, textFilter, ratingFilter in

                allMovieVMs.values.sorted { lhs, rhs in

                    lhs.title < rhs.title
                }
                .filter { movieVM in

                    var filterTextResult = true
                    var filterRatingResult = true

                    if !textFilter.isEmpty {

                        filterTextResult = movieVM.title.contains(textFilter)
                    }

                    if !ratingFilter.isEmpty {

                       filterRatingResult = ratingFilter.contains(movieVM.rating)
                    }

                    return filterTextResult && filterRatingResult
                }
            }
        }

        func updateTextFilter(text: String) {

            filterRelay.text.accept(text)
        }

        func updateRatingFilter(rating: Int) {

            var ratingFilters = filterRelay.rating.value

            if ratingFilters.contains(rating) {

                ratingFilters.remove(rating)

            } else {

                ratingFilters.insert(rating)
            }

            print("Updated rating filter with rating = \(ratingFilters)")

            filterRelay.rating.accept(ratingFilters)
        }

        func refreshAvailableMovies() {

            refreshDisposable.disposable = model.refreshAvailableMovies()

                .do(onSubscribe: { [weak self] in

                    self?.refreshRelay.accept(true)

                }, onDispose: { [weak self] in

                    self?.refreshRelay.accept(false)
                })
                .subscribe()

            refreshDisposable.disposed(by: disposeBag)
        }

        // MARK: Privates:

        private let disposeBag = DisposeBag()
        private let model: Movie.Manager.Interface
        private let refreshRelay = BehaviorRelay(value: false)

        private var refreshDisposable = SerialDisposable()
        private var filterRelay = (

            text: BehaviorRelay(value: ""),
            rating: BehaviorRelay<Set<Int>>(value: [])
        )

    } // Impl

} // Search.VM
