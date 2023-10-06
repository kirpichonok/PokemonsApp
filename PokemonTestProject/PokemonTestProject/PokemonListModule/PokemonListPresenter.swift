import SwiftUI

final class PokemonListPresenter: PokemonListViewInputing {
    // MARK: - Internal interface

    @MainActor @Published var list = [PokemonIdentity]()
    @MainActor @Published var isErrorOccurred = false

    init(interactor: PokemonListInteractorInputing) {
        self.interactor = interactor
    }

    func obtainListOfPokemons() async {
        do {
            let list = try await interactor.obtainListOfPokemons()
            await MainActor.run { self.list = list }
        } catch {
            await MainActor.run { self.isErrorOccurred = true }
        }
    }

    // MARK: - Private interface

    private let interactor: PokemonListInteractorInputing
}
