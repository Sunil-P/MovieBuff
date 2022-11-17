//
//  Person+VM.swift
//  FrontendAppKit
//
//  Created by Subhrajyoti Patra on 11/13/22.
//

import RxSwift
import Swinject
import UIKit

protocol Person_VM_Interface {

    var name: String { get }
    var character: String? { get }

    func getImage() -> Single<UIImage>
}

extension Person {

    struct VM {

        typealias Interface = Person_VM_Interface

        enum PersonError: Error {

            case noImageUrl
        }

        class Impl: Interface {

            init(

                name: String,
                character: String? = nil,
                imageUrl: URL,
                resolver: Resolver

            ) {

                self.name = name
                self.character = character
                self.url = imageUrl
                self.dataStoreManager = DataStore.Manager.Factory.create(with: resolver)
            }

            // MARK: Interface:

            var name: String
            var character: String?

            func getImage() -> Single<UIImage> {

                dataStoreManager.getImage(from: url)
            }

            // MARK: Privates:

            private let url: URL
            private let dataStoreManager: DataStore.Manager.Interface
        }
    }

}
