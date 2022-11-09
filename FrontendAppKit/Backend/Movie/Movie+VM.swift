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
    var isFavourite: Driver<Bool> { get }

    func toggleFavorite()
    func getImage() -> Single<UIImage>
    func getImage(successHandler: ((UIImage)->())?, errorHandler: ((Error)->())?)

} // Movie_ViewModel_Interface

extension Movie {

    class VM {

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
