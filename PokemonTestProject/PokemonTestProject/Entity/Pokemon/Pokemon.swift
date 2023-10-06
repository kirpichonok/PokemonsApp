import Foundation

struct Pokemon: Codable {
    let id: Int?
    let name = ""
    let type: String
    let weight: Int
    let height: Int
    let image: URL?
}
