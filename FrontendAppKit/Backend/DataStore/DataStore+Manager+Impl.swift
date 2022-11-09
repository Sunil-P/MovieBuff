//
//  DataStore+Manager+Impl.swift
//  FrontendAppKit
//
//  Created by Subhrajyoti Patra on 11/6/22.
//

import RxRelay
import RxSwift
import Swinject

extension DataStore.Manager {

    public struct Factory {

        public static func register(

            with container: Container,
            scheduler: SchedulerType?

        ) {

            container.register(

                Interface.self

            ) { _ in

                Impl(

                    with: container.synchronize()
                )
            }
            .inObjectScope(.container)
        }

        static func create(

            with resolver: Resolver

        ) -> Interface {

            resolver.resolve(Interface.self)!
        }

    } // Factory

    final class Impl: Interface {

        init(with resolver: Resolver) {

            getFavoritedMovies()
            refreshAvailableMovies().subscribe().disposed(by: disposeBag)
            refreshStaffPickMovies().subscribe().disposed(by: disposeBag)
        }

        // MARK: Interface:

        var favoritedMovieIds: Observable<Set<Int>> {

            relay.favoriteMovieIds.asObservable()
        }

        var staffPickMovieIds: Observable<Set<Int>> {

            relay.staffPickMovieIds.asObservable()
        }

        var availableMovies: Observable<[Int: Movie.DecodableModel.MovieModel]> {

            relay.availableMovies.asObservable()
        }

        func refreshAvailableMovies() -> Completable {

            .create { completable in

                let url = URL(string: "https://apps.agentur-loop.com/challenge/movies.json")!
                var request = URLRequest(url: url)
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")

                let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in

                    guard let this = self else {

                        return
                    }

                    if let data = data {

                        let jsonDecoder = JSONDecoder()
                        jsonDecoder.dateDecodingStrategy = .custom(this.customDateParser)

                        do {

                            let movies = try jsonDecoder.decode([Movie.DecodableModel.MovieModel].self, from: data)
                            print("Successfully fetched movies.")

                            var moviesDict = [Int: Movie.DecodableModel.MovieModel]()

                            movies.forEach {

                                moviesDict[$0.id] = $0
                            }

                            this.relay.availableMovies.accept(moviesDict)

                            completable(.completed)

                        } catch  {

                            print(error)

                            completable(.error(DataStoreError.unableToParse))
                        }

                    } else if let error = error {

                        print("HTTP Request Failed \(error)")

                        completable(.error(DataStoreError.httpRequestFailure))
                    }
                }

                task.resume()

                return Disposables.create {}
            }
        }

        func refreshStaffPickMovies() -> Completable {

            .create { completable in

                let url = URL(string: "https://apps.agentur-loop.com/challenge/staff_picks.json")!
                var request = URLRequest(url: url)
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")

                let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in

                    guard let this = self else {

                        return
                    }

                    if let data = data {

                        let jsonDecoder = JSONDecoder()
                        jsonDecoder.dateDecodingStrategy = .custom(this.customDateParser)

                        do {

                            let movies = try jsonDecoder.decode([Movie.DecodableModel.MovieModel].self, from: data)
                            print("Successfully fetched movies.")

                            let set = Set(movies.map { $0.id })

                            this.relay.staffPickMovieIds.accept(set)

                            completable(.completed)

                        } catch  {

                            print(error)

                            completable(.error(DataStoreError.unableToParse))
                        }

                    } else if let error = error {

                        print("HTTP Request Failed \(error)")

                        completable(.error(DataStoreError.httpRequestFailure))
                    }
                }

                task.resume()

                return Disposables.create { }
            }
        }

        func updateFavoriteMovie(id: Int) {

            var favoriteMovieIds = relay.favoriteMovieIds.value

            if favoriteMovieIds.contains(id) {

                favoriteMovieIds.remove(id)

            } else {

                favoriteMovieIds.insert(id)
            }

            relay.favoriteMovieIds.accept(favoriteMovieIds)
            UserDefaults.standard.set(Array(favoriteMovieIds), forKey: "favorite_movies")
            UserDefaults.standard.synchronize()
        }

        func getImage(fromUrl: URL) -> Single<UIImage> {

            .create { single in

                single(.success(UIImage()))
                return Disposables.create { }
            }
        }

        // MARK: Privates:

        private let disposeBag = DisposeBag()
        private let relay = (

            availableMovies: BehaviorRelay(value: [Int: Movie.DecodableModel.MovieModel]()),
            staffPickMovieIds: BehaviorRelay(value: Set<Int>()),
            favoriteMovieIds: BehaviorRelay(value: Set<Int>())
        )

        private func customDateParser(_ decoder: Decoder) throws -> Date {

            let dateString = try decoder.singleValueContainer().decode(String.self)

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY-MM-DD"

            do {

                if let date = dateFormatter.date(from: dateString) {

                    return date

                } else {

                    throw DataStoreError.unableToParse
                }

            } catch {

                print("Error: \(error.localizedDescription)")
                print("Unable to parse date. \(dateString)")

                return Date()
            }
        }

        private func getFavoritedMovies() {

            if let array = UserDefaults.standard.array(forKey: "favorite_movies") {

                let favoriteMovieIds = array as? [Int] ?? [Int]()
                relay.favoriteMovieIds.accept(Set(favoriteMovieIds))
            }
        }

    } // Impl

} // DataStore.Manager
