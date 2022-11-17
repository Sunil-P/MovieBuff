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

            // print("Movie.VM constructing...")

            self.resolver = resolver
            self.movieModel = spec.movieModel

            self.dataStoreManager = DataStore.Manager.Factory.create(with: resolver)

            // print("Movie.VM has been constructed.")
        }

        deinit {

            // print("~Movie.VM has been destructed.")
        }

        // MARK: Interface:

        var id: Int {

            movieModel.id
        }

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

        var runtime: String {

            let durationFormatter = DateComponentsFormatter()
            durationFormatter.allowedUnits = [.hour, .minute]
            durationFormatter.unitsStyle = .abbreviated

            let movieDurationStr = durationFormatter.string(from: TimeInterval(movieModel.runtime*60))!

            let dateFormatter = DateFormatter()

            dateFormatter.dateFormat = "dd.MM.yyyy"
            let dateStr = dateFormatter.string(from: movieModel.releaseDate)

            return "\(dateStr) · \(movieDurationStr)"
        }

        var movieTags: [String] {

            movieModel.genres
        }

        var overview: String {

            movieModel.overview
        }

        var factBudget: String {

            formatter(value: movieModel.budget)
        }

        var factRevenue: String {

            if let revenue = movieModel.revenue {

                return formatter(value: revenue)
            }

            return ""
        }

        var factLanguage: String {

            Locale.current.localizedString(forLanguageCode: movieModel.language) ?? ""
        }

        var factRating: String {

            "\(String(format: "%.2f", movieModel.rating)) (\(movieModel.reviews))"
        }

        var director: Person.VM.Interface {

            Person.VM.Impl(

                name: movieModel.director.name,
                character: nil,
                imageUrl: movieModel.director.pictureUrl,
                resolver: resolver
            )
        }

        var cast: [Person.VM.Interface] {

            movieModel.cast.map {

                Person.VM.Impl(

                    name: $0.name,
                    character: $0.character,
                    imageUrl: $0.pictureUrl,
                    resolver: resolver
                )
            }
        }

        func toggleFavorite() {

            dataStoreManager.updateFavoriteMovie(id: movieModel.id)
        }

        func getImage() -> Single<UIImage> {

            dataStoreManager.getImage(from: movieModel.posterUrl)
        }

        // MARK: Privates:

        private let resolver: Resolver
        private let movieModel: Movie.DecodableModel.MovieModel
        private let dataStoreManager: DataStore.Manager.Interface

        private func formatter(value: Int) -> String {

            let formatter = NumberFormatter()
            formatter.currencySymbol = "$ "
            formatter.currencyCode = "USD"
            formatter.numberStyle = .currency
            formatter.currencyGroupingSeparator = "."
            formatter.maximumFractionDigits = 0

            return formatter.string(from: NSNumber(value: value)) ?? ""
        }

    } // Impl

} // Movie.VM
