import SwiftUI

struct PokemonDetailView: View {
    @ObservedObject var presenter: PokemonDetailPresenter

    var body: some View {
        VStack {
            Image(uiImage: presenter.image ?? UIImage(imageLiteralResourceName: "AppIcon"))
                .resizable()
                .frame(maxWidth: 300, maxHeight: 300)
                .aspectRatio(contentMode: .fit)
                .background(gradient)
                .clipShape(Circle())
                .padding()

            List {
                Text(presenter.name)
                Text(presenter.height)
                Text(presenter.weight)
                Text(presenter.type)
            }
        }
        .padding()
        .task {
            await presenter.obtainPokemonInfo()
        }
    }

    // MARK: - Private interface

    private let gradient = LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing)
}

#Preview {
    PokemonDetailView(presenter: PokemonDetailPresenter(interactor: PokemonDetailInteractor(identifier: PokemonIdentity(id: 1, name: "hello"))))
}
