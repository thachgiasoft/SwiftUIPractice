//
//  PokemonRootView.swift
//  SwiftUIPractice
//
//  Created by lizhu on 2020/4/21.
//  Copyright © 2020 lizhu. All rights reserved.
//

import SwiftUI

struct PokemonRootView: View {
    var body: some View {
        NavigationView {
            PokemonList().navigationBarTitle("宝可梦列表")
        }
    }
}

struct PokemonRootView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonRootView()
    }
}
