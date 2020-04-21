//
//  AppCommand.swift
//  SwiftUIPractice
//
//  Created by lizhu on 2020/4/21.
//  Copyright © 2020 lizhu. All rights reserved.
//

import Foundation

protocol AppCommand {
    func execute(in stroe: Store)
}

struct LoginAppCommand:AppCommand {
    let email: String
    let password: String
    
    func execute(in store: Store) {
        _ = LoginRequest(email: email, password: password).publiser
            .sink(receiveCompletion: { (complete) in
                if case .failure(let error) = complete {
                    store.dispatch(.accountBehaviorDone(result: .failure(error)))
                }
            }, receiveValue: { (user) in
                store.dispatch(.accountBehaviorDone(result: .success(user)))
            })
    }
}
