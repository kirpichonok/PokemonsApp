import Combine
import Foundation

final class PokemonDetailInteractor {
    // MARK: - Internal interface

    @Published var isErrorOccurred = false
    @Published var pokemon: Pokemon?
    @Published var imageData: Data?

    init(identifier: PokemonIdentity) {
        self.identifier = identifier
    }

    func obtainPokemonInfo() async {
        do {
            let pokemonAPI = DataSourceAPI.pokemonInfo(id: identifier.id)
            let data = try await networkService.load(from: pokemonAPI)
            pokemon = try JSONDecoder().decode(Pokemon.self, from: data)

        } catch {
            await MainActor.run { isErrorOccurred = true }
        }
    }

    // MARK: - Private interface

    private let identifier: PokemonIdentity
    private let networkService = NetworkService()

    private func loadPokemonInfo() async {
        do {
            let pokemonAPI = DataSourceAPI.pokemonInfo(id: identifier.id)
            let data = try await networkService.load(from: pokemonAPI)
            pokemon = try JSONDecoder().decode(Pokemon.self, from: data)

        } catch {
            await MainActor.run { isErrorOccurred = true }
        }
    }

    private func loadPokemonImage() async {
        guard let url = pokemon?.image else { return }
        let data = try? await networkService.load(from: url)
        await MainActor.run {
            imageData = data
        }
    }
}
