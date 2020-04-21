//
//  Store.swift
//  SwiftUIPractice
//
//  Created by lizhu on 2020/4/21.
//  Copyright © 2020 lizhu. All rights reserved.
//

import Foundation
import Combine

class Store: ObservableObject {
    @Published
    var appState = AppState()
    
    func dispatch(_ action: AppAction) {
        #if DEBUG
        print("[ACTION:\(action)")
        #endif
        
        let result = Store.reduce(state: appState, action: action)
        appState = result.0
        
        if let command = result.1 {
            #if DEBUG
            print("[command]:\(command)")
            #endif
            command.execute(in: self)
        }
    }
    
    static func reduce(state: AppState, action: AppAction) -> (AppState, AppCommand?) {
        var apppState = state
        var appCommand: AppCommand?
        
        switch action {
        case .login(let email, let password):
            guard !apppState.settings.loginRequesting else {
                break
            }
            apppState.settings.loginRequesting = true
            appCommand = LoginAppCommand(email: email, password: password)
        case .accountBehaviorDone(let result):
            print("")
            apppState.settings.loginRequesting = false
            switch result {
            case .success(let user):
                apppState.settings.loginUser = user
            case .failure(let error):
                apppState.settings.loginError = error
            }
        }
        return (apppState, appCommand)
    }
}
