import SwiftUI

class PokemonListRouter {
    func makeDetailView(for identifier: PokemonIdentity) -> some View {
        let presenter = PokemonDetailPresenter(
            interactor: PokemonDetailInteractor(
                identifier: identifier
            )
        )
        return PokemonDetailView(presenter: presenter)
    }
}
