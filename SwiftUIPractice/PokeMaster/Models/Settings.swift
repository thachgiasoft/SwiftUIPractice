//
//  Settings.swift
//  SwiftUIPractice
//
//  Created by lizhu on 2020/4/21.
//  Copyright © 2020 lizhu. All rights reserved.
//

import SwiftUI

class Settings: ObservableObject{
    enum AccountBehavoir: CaseIterable{
        case register, login
    }
    
    enum Sorting: CaseIterable {
        case id, name, color, favorite
    }
    
    @Published
    var accountBehavior = AccountBehavoir.login
    
    @Published
    var email = ""
    
    @Published
    var password = ""
    
    @Published
    var verifyPassword = ""
    
    @Published
    var showEnglishName = true
    
    @Published
    var sorting = Sorting.id
    
    @Published
    var showFavoriteOnly = false
    
}

extension Settings.Sorting{
    var text: String {
        switch self {
        case .id:
            return "ID"
        case .name:
            return "名字"
        case .color:
            return "颜色"
        case .favorite:
            return "最爱"
        }
    }
}

extension Settings.AccountBehavoir{
    var text: String {
        switch self {
        case .register:
            return "注册"
        case .login:
            return "登录"
        }
    }
}
