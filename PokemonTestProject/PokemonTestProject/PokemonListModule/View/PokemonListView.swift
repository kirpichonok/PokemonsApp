import SwiftUI

struct PokemonListView<ListSource>: View where ListSource: PokemonListViewInputing {
    @ObservedObject var presenter: ListSource
    
    var body: some View {
        List {
            ForEach(presenter.list, id: \.id) { pokemon in
//                self.presenter.linkBuilder(for: pokemon) {
                    Text(pokemon.name)
//                }
            }
        }
        .navigationBarTitle("Pokemons", displayMode: .inline)
        .task {
           await presenter.obtainListOfPokemons()
        }
        .alert("Error", isPresented: $presenter.isErrorOccurred) {
            Button("Dismiss") {}
        }
    }
}

//#Preview {
//
//}




