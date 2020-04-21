//
//  PokemonList.swift
//  SwiftUIPractice
//
//  Created by lizhu on 2020/4/20.
//  Copyright © 2020 lizhu. All rights reserved.
//

import SwiftUI

struct PokemonList: View {
    @State
    var expandingIndex: Int?
    
    @State
    var searchText: String = ""
    
    var body: some View {
        ScrollView {
            TextField("搜索", text: $searchText)
            ForEach(PokemonViewModel.all) { pokemon in
                PokemonInfoRow(
                    model: pokemon,
                    expanded: self.expandingIndex == pokemon.id
                )
                .onTapGesture {
                    if self.expandingIndex == pokemon.id {
                        self.expandingIndex = nil
                    } else {
                        self.expandingIndex = pokemon.id
                    }
                }
            }
        }
    }
}

struct PokemonList_Previews: PreviewProvider {
    static var previews: some View {
        PokemonList()
    }
}
