import Combine
import UIKit

final class PokemonDetailPresenter: ObservableObject {
    @Published var name = ""
    @Published var height = ""
    @Published var weight = ""
    @Published var image: UIImage?
    @Published var isErrorOccurred = false
    @Published var type = ""

    init(interactor: PokemonDetailInteractor) {
        self.interactor = interactor

        interactor.$pokemon
            .compactMap(\.?.name)
            .assign(to: \.name, on: self)
            .store(in: &cancellables)

        interactor.$pokemon
            .compactMap(\.?.height)
            .map { self.heightLabelText($0) }
            .assign(to: \.height, on: self)
            .store(in: &cancellables)

        interactor.$pokemon
            .compactMap(\.?.weight)
            .map { self.weightLabelText($0) }
            .assign(to: \.weight, on: self)
            .store(in: &cancellables)

        interactor.$pokemon
            .compactMap(\.?.type)
            .map { self.typeLabelText($0) }
            .assign(to: \.type, on: self)
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

    func obtainPokemonInfo() async {
        await interactor.obtainPokemonInfo()
    }

    // MARK: - Private interface

    private let interactor: PokemonDetailInteractor
    private var cancellables = Set<AnyCancellable>()

    private func weightLabelText(_ value: Int) -> String {
        "Weight: \(value)kg"
    }

    private func heightLabelText(_ value: Int) -> String {
        "Height: \(value) meters"
    }

    private func typeLabelText(_ value: String) -> String {
        "Type: \(value)"
    }
}
