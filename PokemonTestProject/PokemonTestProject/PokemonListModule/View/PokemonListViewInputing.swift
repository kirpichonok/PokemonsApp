import SwiftUI

protocol PokemonListViewInputing: ObservableObject {
    var list: [PokemonIdentity] { get }
    func obtainListOfPokemons() async
    var isErrorOccurred: Bool { get set }
}
