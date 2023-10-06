protocol PokemonListInteractorInputing: AnyObject {
    func obtainListOfPokemons() async throws -> [PokemonIdentity]
}
