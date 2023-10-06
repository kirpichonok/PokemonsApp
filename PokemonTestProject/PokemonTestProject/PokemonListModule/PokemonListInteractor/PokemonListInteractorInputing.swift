protocol PokemonListInteractorInputing: AnyObject {
//    var isErrorOccurred: Bool { get set }
//    var list: [PokemonIdentity] { get set }
    func obtainListOfPokemons() async
}
