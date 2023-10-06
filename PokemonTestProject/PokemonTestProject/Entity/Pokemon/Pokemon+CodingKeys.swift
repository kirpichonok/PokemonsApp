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
    }

    init(from decoder: Decoder) throws {
        self.id = nil
        var container = try decoder.container(keyedBy: AnyCodingKey.self)
        height = try container.decode(Int.self, forKey: AnyCodingKey(stringValue: "height"))
        weight = try container.decode(Int.self, forKey: AnyCodingKey(stringValue: "weight"))

        let spritesContainer = try container.nestedContainer(keyedBy: AnyCodingKey.self, forKey: AnyCodingKey(stringValue: "sprites"))
        image = try spritesContainer.decode(URL.self, forKey: AnyCodingKey(stringValue: "front_default"))

        let typesContainer = try container.nestedContainer(keyedBy: AnyCodingKey.self, forKey: AnyCodingKey(stringValue: "types"))
        let slotOneContainer = try typesContainer.nestedContainer(keyedBy: AnyCodingKey.self, forKey: AnyCodingKey(intValue: 0))
        let typeContainer = try container.nestedContainer(keyedBy: AnyCodingKey.self, forKey: AnyCodingKey(stringValue: "type"))
        self.type = try typeContainer.decode(String.self, forKey: AnyCodingKey(stringValue: "name"))
    }
}
