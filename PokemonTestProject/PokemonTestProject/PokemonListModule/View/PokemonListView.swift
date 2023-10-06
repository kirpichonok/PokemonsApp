import SwiftUI

struct PokemonListView<ListSource>: View where ListSource: PokemonListViewInputing {
    @ObservedObject var presenter: PokemonListPresenter

    var body: some View {
        List {
            ForEach(presenter.list, id: \.id) { pokemon in
                self.presenter.linkBuilder(for: pokemon) {
                    Text(pokemon.name)
                }
            }
            .alert("Error", isPresented: $presenter.isErrorOccurred) {
                Button("Dismiss") {}
            }
        }
        .navigationBarTitle("Pokemons", displayMode: .inline)
        .task {
            await presenter.obtainListOfPokemons()
        }
    }
}

// #Preview {
//
// }
