//
//  Swinject+Additions.swift
//  FrontendAppKit
//
//  Created by Subhrajyoti Patra on 11/17/22.
//

import Swinject

extension Container {

    public struct SyncPair {

        public let container = Container()

        public let resolver: Resolver

        public init() {

            self.resolver = container.synchronize()
        }
    }

    public static let `default` = SyncPair()
}
