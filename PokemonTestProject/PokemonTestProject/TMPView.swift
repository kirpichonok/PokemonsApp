import SwiftUI

struct TMPView: View {
    let destination: PokemonListView<PokemonListPresenter>

    var body: some View {
        NavigationLink(destination: destination) {
            Text("ListOfPokemons")
        }
    }
}
