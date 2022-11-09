//
//  Movie+VM+Impl.swift
//  FrontendAppKit
//
//  Created by Subhrajyoti Patra on 11/9/22.
//

import RxCocoa
import RxSwift
import Swinject

extension Movie.VM {

    struct Factory {

        static func register(

            with container: Container,
            scheduler: SchedulerType?

        ) {

            container.register(

                Interface.self

            ) { (_, spec: Spec) in

                Impl(

                    with: container.synchronize(),
                    scheduler: scheduler ?? MainScheduler.instance,
                    spec: spec
                )
            }
            .inObjectScope(.transient)
        }

        static func create(with resolver: Resolver, spec: Spec) -> Interface {

            resolver.resolve(Interface.self, argument: spec)!
        }

    } // Factory

    // MARK: -

    private final class Impl: Interface {

        init(with resolver: Resolver, scheduler: SchedulerType, spec: Spec) {

            self.movieModel = spec.movieModel

            self.dataStoreManager = DataStore.Manager.Factory.create(with: resolver)
        }

        // MARK: Interface:

        var rating: Int {

            Int(movieModel.rating.rounded())
        }
        var title: String {

            movieModel.title
        }

        var isFavourite: Driver<Bool> {

            dataStoreManager.favoritedMovieIds

                .map { [movieModel] in

                    $0.contains(movieModel.id)
                }
                .asDriver(onErrorDriveWith: .never())
        }

        var releaseYear: String {

            let dateFormatter = DateFormatter()

            dateFormatter.dateFormat = "yyyy"

            return dateFormatter.string(from: movieModel.releaseDate)
        }

        func toggleFavorite() {

            dataStoreManager.updateFavoriteMovie(id: movieModel.id)
        }

        func getImage() -> Single<UIImage> {

            .create { [movieModel] single in

                let task = URLSession.shared.dataTask(with: movieModel.posterUrl) { data, _, error in

                    guard let data = data, error == nil else {

                        single(.failure(MovieVMError.networkError))
                        return
                    }

                    if let image = UIImage(data: data) {

                        single(.success(image))

                    } else {

                        single(.failure(MovieVMError.invalidData))
                    }
                }

                task.resume()
                return Disposables.create()
            }
        }

        func getImage(successHandler: ((UIImage)->())?, errorHandler: ((Error)->())?) {

            let task = URLSession.shared.dataTask(with: movieModel.posterUrl) { data, _, error in

                guard let data = data, error == nil else {

                    errorHandler?(MovieVMError.networkError)
                    return
                }

                if let image = UIImage(data: data) {

                    successHandler?(image)

                } else {

                    errorHandler?(MovieVMError.invalidData)
                }
            }

            task.resume()
        }

        // MARK: Privates:

        private let movieModel: Movie.DecodableModel.MovieModel
        private let dataStoreManager: DataStore.Manager.Interface

    } // Impl

} // Movie.VM
