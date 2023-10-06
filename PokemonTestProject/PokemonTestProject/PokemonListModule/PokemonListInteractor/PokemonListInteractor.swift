import SwiftUI

final class PokemonListInteractor: PokemonListInteractorInputing {
    @Published var list = [PokemonIdentity]()
    @Published var isErrorOccurred = false

    func obtainListOfPokemons() async {
        do {
            let data = try await networkService.load(from: listOfPokemonsAPI)
            let responseWithList = try decoder.decode(ListOfPokemons.self, from: data)
            await MainActor.run { list = responseWithList.list }
        } catch {
            await MainActor.run { isErrorOccurred = true }
        }
    }

    private let listOfPokemonsAPI = DataSourceAPI.listOfPokemons
    private let networkService = NetworkService()
    private let decoder = JSONDecoder()
}
