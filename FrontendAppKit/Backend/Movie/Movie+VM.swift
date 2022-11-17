//
//  Movie+VM.swift
//  FrontendAppKit
//
//  Created by Subhrajyoti Patra on 11/9/22.
//

import RxCocoa
import RxSwift
import UIKit

protocol Movie_ViewModel_Interface {

    var rating: Int { get }
    var title: String { get }
    var releaseYear: String { get }
    var runtime: String { get }
    var movieTags: [String] { get }
    var overview: String { get }
    var isFavourite: Driver<Bool> { get }
    var factBudget: String { get }
    var factRevenue: String { get }
    var factLanguage: String { get }
    var factRating: String { get }

    var director: Person.VM.Interface { get }
    var cast: [Person.VM.Interface] { get }

    func toggleFavorite()
    func getImage() -> Single<UIImage>

} // Movie_ViewModel_Interface

extension Movie {

    struct VM {

        struct Spec {

            let movieModel: Movie.DecodableModel.MovieModel
        }

        enum MovieVMError: Error {

            case invalidData
            case networkError
        }

        typealias Interface = Movie_ViewModel_Interface
    }
}
