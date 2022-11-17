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

            print("DataStore.Manager constructing...")

            getFavoritedMovies()
            refreshAvailableMovies().subscribe().disposed(by: disposeBag)
            refreshStaffPickMovies().subscribe().disposed(by: disposeBag)

            print("DataStore.Manager has been constructed.")
        }

        deinit {

            print("~DataStore.Manager has been destructed.")
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

                let url = URL(string: Values.URLs.availableMovies)!
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
                            print("Successfully fetched available movies.")

                            var moviesDict = [Int: Movie.DecodableModel.MovieModel]()

                            movies.forEach {

                                moviesDict[$0.id] = $0
                            }

                            this.relay.availableMovies.accept(moviesDict)

                            completable(.completed)

                        } catch  {

                            print(error)

                            print("Error: (\(error.localizedDescription))")
                            completable(.error(DataStoreError.unableToParse))
                        }

                    } else if let error = error {

                        print("Error: (\(error.localizedDescription))")
                        completable(.error(DataStoreError.httpRequestFailure))
                    }
                }

                task.resume()

                return Disposables.create {}
            }
        }

        func refreshStaffPickMovies() -> Completable {

            .create { completable in

                let url = URL(string: Values.URLs.staffPickMovies)!
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
                            print("Successfully fetched staff pick movies.")

                            let set = Set(movies.map { $0.id })

                            this.relay.staffPickMovieIds.accept(set)

                            completable(.completed)

                        } catch  {

                            print("Error: (\(error.localizedDescription))")
                            completable(.error(DataStoreError.unableToParse))
                        }

                    } else if let error = error {

                        print("Error: (\(error.localizedDescription))")
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
            UserDefaults.standard.set(Array(favoriteMovieIds), forKey: Values.favoriteMoviesUserDefaultsKey)
            UserDefaults.standard.synchronize()

            print("Favorite Movie Ids updated, ids=\(favoriteMovieIds)")
        }

        func getImage(from url: URL) -> Single<UIImage> {

            .create { [weak self] single in

                if let image = self?.imageCache[url.absoluteString] {

//                    print("Successfully retrieved image from cache (url=...\(url.absoluteString.suffix(10))).")
                    single(.success(image))

                } else {

                    let task = URLSession.shared.dataTask(with: url) { data, _, error in

                        guard let data = data else {

                            single(.failure(DataStoreError.httpRequestFailure))
                            return
                        }

                        if let error = error {

                            print("Error: \(error.localizedDescription)")
                            return
                        }

                        if let image = UIImage(data: data) {

//                            print(
//                                """
//                                Downloaded image and stored in cache (url=...\(url.absoluteString.suffix(10))).
//                                """
//                            )

                            self?.imageCache[url.absoluteString] = image
                            single(.success(image))

                        } else {

                            single(.failure(DataStoreError.httpRequestFailure))
                        }
                    }

                    task.resume()
                }

                return Disposables.create { }
            }
        }

        // MARK: Privates:

        private typealias Values = DataStore.Values

        private let disposeBag = DisposeBag()
        private let relay = (

            availableMovies: BehaviorRelay(value: [Int: Movie.DecodableModel.MovieModel]()),
            staffPickMovieIds: BehaviorRelay(value: Set<Int>()),
            favoriteMovieIds: BehaviorRelay(value: Set<Int>())
        )

        private var imageCache = [String: UIImage]()

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

            if let array = UserDefaults.standard.array(forKey: Values.favoriteMoviesUserDefaultsKey) {

                let favoriteMovieIds = array as? [Int] ?? [Int]()
                relay.favoriteMovieIds.accept(Set(favoriteMovieIds))
            }
        }

    } // Impl

} // DataStore.Manager
