import Combine
import UIKit

final class PokemonDetailPresenter: ObservableObject {
    @Published var name = ""
    @Published var height = ""
    @Published var weight = ""
    @Published var image: UIImage?
    @Published var isErrorOccurred = false

    init(interactor: PokemonDetailInteractor) {
        self.interactor = interactor

        interactor.$pokemon
            .compactMap(\.?.name)
            .assign(to: \.name, on: self)
            .store(in: &cancellables)

        interactor.$pokemon
            .compactMap(\.?.height)
            .map { String($0) }
            .assign(to: \.height, on: self)
            .store(in: &cancellables)

        interactor.$pokemon
            .compactMap(\.?.weight)
            .map { String($0) }
            .assign(to: \.weight, on: self)
            .store(in: &cancellables)

        interactor.$isErrorOccurred
            .assign(to: \.isErrorOccurred, on: self)
            .store(in: &cancellables)

        interactor.$imageData
            .map { data in
                guard let data else { return nil }
                return UIImage(data: data)
            }
            .assign(to: \.image, on: self)
            .store(in: &cancellables)
    }

    func loadPokemonInfo() async {
        await interactor.obtainPokemonInfo()
    }

    // MARK: - Private interface

    private let interactor: PokemonDetailInteractor
    private var cancellables = Set<AnyCancellable>()
}
