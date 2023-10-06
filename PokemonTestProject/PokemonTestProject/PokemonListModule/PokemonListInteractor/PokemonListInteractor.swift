import SwiftUI

final class PokemonListInteractor: PokemonListInteractorInputing {
    @Published var list = [PokemonIdentity]()
    @Published var isErrorOccurred = false
    
    func obtainListOfPokemons() async throws -> [PokemonIdentity] {
        let data = try await networkService.load(from: listOfPokemonsAPI)
        let listOfPokemons = try decoder.decode(ListOfPokemons.self, from: data)
        return listOfPokemons.list
    }
    
    private let listOfPokemonsAPI = DataSourceAPI.listOfPokemons
    private let networkService = NetworkService()
    private let decoder = JSONDecoder()
}
