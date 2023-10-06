import Foundation

protocol NetworkServicing {
    func load(from: DataSourceAPI) async throws -> Data
}
