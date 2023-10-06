import Combine
import Foundation

final class PokemonDetailPresenter: ObservableObject {
    @Published var name = ""
    @Published var height = ""
    @Published var weight = ""
    @Published var image: Data
    @Published var isErrorOccurred = false
    
    init(interactor: PokemonDetailInteractor) {
        self.interactor = interactor
        
        interactor.$name
            .assign(to: \.name, on: self)
            .store(in: &cancellables)
        
        interactor.$height
            .map { String($0)}
            .assign(to: \.height, on: self)
            .store(in: &cancellables)
        
        interactor.$weight
            .map { String($0)}
            .assign(to: \.weight, on: self)
            .store(in: &cancellables)
        
        interactor.$isErrorOccurred
            .assign(to: \.isErrorOccurred, on: self)
            .store(in: &cancellables)
    }
    
    func loadPokemonInfo() async {
        await interactor.obtainPokemonInfo()
    }
    // MARK: - Private interface
    
    private let interactor: PokemonDetailInteractor
    private var cancellables = Set<AnyCancellable>()
}
