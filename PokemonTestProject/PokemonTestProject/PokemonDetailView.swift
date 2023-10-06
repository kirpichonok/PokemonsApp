import SwiftUI

struct PokemonDetailView<Presenter>: View where Presenter: ObservableObject {
    @ObservedObject var presenter: Presenter

    var body: some View {
        VStack {}
    }
}

#Preview {
    PokemonDetailView(presenter: PokemonDetailPresenter(interactor: PokemonDetailInteractor(identifier: PokemonIdentity(id: 1, name: "hello"))))
}
