import Foundation

struct ListOfPokemons: Decodable {
    let list: [PokemonIdentity]

    enum CodingKeys: String, CodingKey {
        case list = "results"

        enum PokemonsKeys: String, CodingKey {
            case name
            case url
        }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        var pokemonsContainer = try container.nestedUnkeyedContainer(forKey: .list)

        var list = [PokemonIdentity]()
        while !pokemonsContainer.isAtEnd {
            let onePokemon = try pokemonsContainer.nestedContainer(keyedBy: CodingKeys.PokemonsKeys.self)
            let name = try onePokemon.decode(String.self, forKey: .name)
            let stringURL = try (onePokemon.decode(String.self, forKey: .url))
            let lastURLComponent = stringURL.split(separator: "/").last
            if let lastURLComponent, let id = Int(lastURLComponent) {
                list.append(PokemonIdentity(id: id, name: name))
            }
        }
        self.list = list
    }
}
