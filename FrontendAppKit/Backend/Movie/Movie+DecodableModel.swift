//
//  Movie+DecodableModel.swift
//  FrontendAppKit
//
//  Created by Subhrajyoti Patra on 11/9/22.
//

extension Movie {

    struct DecodableModel {

        struct Director: Decodable {

            let name: String
            let pictureUrl: URL
        }

        struct Cast: Decodable {

            let name: String
            let character: String
            let pictureUrl: URL
        }

        struct MovieModel: Identifiable, Decodable {

            let id: Int
            let budget: Int
            let reviews: Int
            let runtime: Int
            let cast: [Cast]
            let revenue: Int?
            let title: String
            let posterUrl: URL
            let rating: Double
            let overview: String
            let language: String
            let genres: [String]
            let releaseDate: Date
            let director: Director

        } // MovieModel
    }
}
