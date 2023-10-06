import SwiftUI

protocol PokemonListViewOutputting {
    associatedtype ViewModel where ViewModel: ObservableObject & PokemonListViewInputing
    var presenter: ViewModel { get }
}
