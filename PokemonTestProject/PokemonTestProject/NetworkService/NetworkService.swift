import Foundation

final class NetworkService: NetworkServicing {
    // MARK: - Internal interface

    func load(from dataSourceAPI: DataSourceAPI) async throws -> Data {
        try await send(composeRequest(for: dataSourceAPI))
    }

    // MARK: - Private interface

    private func composeRequest(for dataSourceAPI: DataSourceAPI) -> URLRequest {
        var urlRequest = URLRequest(url: dataSourceAPI.url)
        urlRequest.httpMethod = dataSourceAPI.method.rawValue
        return urlRequest
    }

    private func send(_ request: URLRequest) async throws -> Data {
        let (data, response) = try await session.data(for: request)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw NetworkRequestError.responseIsNotSuccess
        }
        return data
    }

    private var session: URLSession = {
        var configuration = URLSessionConfiguration.default
        configuration.waitsForConnectivity = true
        configuration.timeoutIntervalForResource = defaultTimeoutIntervalInSeconds
        return URLSession(configuration: configuration)
    }()

    private static let defaultTimeoutIntervalInSeconds: TimeInterval = 15.0
}
