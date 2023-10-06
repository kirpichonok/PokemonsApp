import Foundation

enum DataSourceAPI {
    case listOfPokemons
    case pokemonInfo(id: Int)
    
    var url: URL {
        let url = URL(string: Self.baseURL)!.appendingPathComponent(Self.path)
        switch self {
            case .listOfPokemons: return url
            case let .pokemonInfo(id):
                return url.appendingPathComponent("\(id)")
        }
    }
    
    var method: HTTPMethod {
        return HTTPMethod.get
    }
    
    var headers: HTTPHeaders {
        return HTTPHeaders()
    }
    

    // MARK: - Private interface
    static private let baseURL = "https://pokeapi.co"
    static private let path = "api/v2/pokemon"
}
