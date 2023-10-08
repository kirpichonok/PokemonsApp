import Foundation

extension Pokemon {
    struct AnyCodingKey: CodingKey {
        var stringValue: String
        var intValue: Int?
        init(_ codingKey: CodingKey) {
            stringValue = codingKey.stringValue
            intValue = codingKey.intValue
        }

        init(stringValue: String) {
            self.stringValue = stringValue
            intValue = nil
        }

        init(intValue: Int) {
            stringValue = String(intValue)
            self.intValue = intValue
        }

        enum TypesCodingKeys: String, CodingKey {
            case type

            enum TypeNameKeys: String, CodingKey {
                case name
            }
        }
    }

    init(from decoder: Decoder) throws {
        id = nil
        let container = try decoder.container(keyedBy: AnyCodingKey.self)
        height = try container.decode(Int.self, forKey: AnyCodingKey(stringValue: AnyCodingKey.heightKey))
        weight = try container.decode(Int.self, forKey: AnyCodingKey(stringValue: AnyCodingKey.weightKey))

        let spritesContainer = try container.nestedContainer(keyedBy: AnyCodingKey.self, forKey: AnyCodingKey(stringValue: AnyCodingKey.spritesContainerKey))
        image = try spritesContainer.decode(URL.self, forKey: AnyCodingKey(stringValue: AnyCodingKey.imageKey))

        var typesContainer = try container.nestedUnkeyedContainer(forKey: AnyCodingKey(stringValue: AnyCodingKey.typeContainerKey))
        let slotContainer = try typesContainer.nestedContainer(keyedBy: AnyCodingKey.TypesCodingKeys.self)
        let typeContainer = try slotContainer.nestedContainer(keyedBy: AnyCodingKey.TypesCodingKeys.TypeNameKeys.self, forKey: .type)

        type = try typeContainer.decode(String.self, forKey: .name)
    }

    // MARK: - Private interface
}

extension Pokemon.AnyCodingKey {
    static let heightKey = "height"
    static let weightKey = "weight"
    static let imageKey = "front_default"
    static let spritesContainerKey = "sprites"
    static let typeContainerKey = "types"
}
