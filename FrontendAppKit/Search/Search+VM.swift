//
//  Search+VM.swift
//  FrontendAppKit
//
//  Created by Subhrajyoti Patra on 11/16/22.
//

import RxSwift

protocol Search_VM_Interface {

    var isRefreshing: Observable<Bool> { get }
    var movieVMs: Observable<[Movie.VM.Interface]> { get }

    func updateTextFilter(text: String)
    func updateRatingFilter(rating: Int)
    func refreshAvailableMovies()

} // Search_VM_Interface

extension Search {

    struct VM {

        typealias Interface = Search_VM_Interface

    } // VM

} // Search
