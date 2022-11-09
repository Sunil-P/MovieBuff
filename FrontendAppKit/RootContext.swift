//
//  RootContext.swift
//  FrontendAppKit
//
//  Created by Subhrajyoti Patra on 11/6/22.
//

import CommonKit
import Swinject
import RxSwift

public struct RootContext {

    public static func register() {

        let container = Container.default.container

        DataStore.Manager.Factory.register(with: container, scheduler: nil)
        Movie.Manager.Factory.register(with: container, scheduler: nil)
        Home.VM.Factory.register(with: container, scheduler: nil)
    }
}
