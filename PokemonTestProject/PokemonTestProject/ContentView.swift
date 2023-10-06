import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            TMPView(destination: PokemonListView(
                presenter: PokemonListPresenter(
                    interactor: PokemonListInteractor())
            ))
        }
    }
}

#Preview {
    ContentView()
}
