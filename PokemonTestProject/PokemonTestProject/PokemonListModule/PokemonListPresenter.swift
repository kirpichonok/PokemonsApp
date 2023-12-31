import Combine
import SwiftUI

final class PokemonListPresenter: PokemonListViewInputing {
    // MARK: - Internal interface

    @MainActor @Published var list = [PokemonIdentity]()
    @MainActor @Published var isErrorOccurred = false

    init(interactor: PokemonListInteractor) {
        self.interactor = interactor
        interactor.$list
            .assign(to: \.list, on: self)
            .store(in: &cancellables)

        interactor.$isErrorOccurred
            .assign(to: \.isErrorOccurred, on: self)
            .store(in: &cancellables)
    }

    func obtainListOfPokemons() async {
        await interactor.obtainListOfPokemons()
    }

    func linkBuilder<Content: View>(
        for identifier: PokemonIdentity,
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(destination: router.makeDetailView(for: identifier)) {
            content()
        }
    }

    // MARK: - Private interface

    private let interactor: PokemonListInteractorInputing
    private var cancellables = Set<AnyCancellable>()
    private let router = PokemonListRouter()
}
