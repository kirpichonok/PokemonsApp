//
//  TMPView.swift
//  PokemonTestProject
//
//  Created by Kirpichonok Ivan on 6.10.23.
//

import SwiftUI

struct TMPView: View {
    let destination: PokemonListView<PokemonListPresenter>

    var body: some View {
        NavigationLink(destination: destination) {
            Text("ListOfPokemons")
        }
    }
}

// #Preview {
//    TMPView()
// }
