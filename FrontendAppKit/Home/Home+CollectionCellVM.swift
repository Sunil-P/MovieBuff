//
//  Home+CollectionCellVM.swift
//  FrontendAppKit
//
//  Created by Subhrajyoti Patra on 11/17/22.
//

protocol CollectionCellVM {

} // CollectionCellVM

class MovieCollectionCellVM: CollectionCellVM {

    let movie: Movie.VM.Interface

    init(movie: Movie.VM.Interface) {

        self.movie = movie
    }

} // MovieCollectionCellVM

class SeeAllCellVM: CollectionCellVM { }
