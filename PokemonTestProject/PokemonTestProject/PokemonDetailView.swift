import SwiftUI

struct PokemonDetailView: View {
    @ObservedObject var presenter: PokemonDetailPresenter

    var body: some View {
        VStack {
            Image(uiImage: presenter.image ?? UIImage(imageLiteralResourceName: "AppIcon"))
                .resizable()
            List {
                Text(presenter.name)
                Text(presenter.height)
                Text(presenter.weight)
            }
        }
        .padding()
    }
}

#Preview {
    PokemonDetailView(presenter: PokemonDetailPresenter(interactor: PokemonDetailInteractor(identifier: PokemonIdentity(id: 1, name: "hello"))))
}
