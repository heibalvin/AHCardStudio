public enum AHCardPackType: Int, CustomStringConvertible, Codable {
    case standard52 = 1
    case standard52one = 2

    public var description: String {
        switch self {
        case .standard52:
            return "standard52"
        case .standard52one:
            return "standard52one"
        }
    }
}

public struct AHCardPack: CustomStringConvertible, Hashable, Codable {
    public var name: String
    public var type: AHCardPackType
    public private(set) var cards: [AHCard]

    public init(name: String, type: AHCardPackType) {
        self.name = name
        self.type = type
        self.cards = Self.cards(for: type)
    }

    public static func standard52(name: String = "Standard 52") -> AHCardPack {
        AHCardPack(name: name, type: .standard52)
    }

    public static func standard52one(name: String = "Standard 52 One") -> AHCardPack {
        AHCardPack(name: name, type: .standard52one)
    }

    public static func standard52Cards() -> [AHCard] {
        cards(for: .standard52)
    }

    public static func standard52oneCards() -> [AHCard] {
        cards(for: .standard52one)
    }

    public mutating func shuffle() {
        cards.shuffle()
    }

    public mutating func reset() {
        cards = Self.cards(for: type)
    }

    public var description: String {
        "\(name) (\(type), \(cards.count) cards): \(cards.map { "\($0)" }.joined(separator: " "))"
    }

    private static func cards(for type: AHCardPackType) -> [AHCard] {
        switch type {
        case .standard52:
            return Self.cards(ranks: Array(2...14))
        case .standard52one:
            return Self.cards(ranks: Array(1...13))
        }
    }

    private static func cards(ranks: [Int]) -> [AHCard] {
        let suits: [Int] = [1, 2, 3, 4]
        return suits.flatMap { suit in
            ranks.map { rank in
                AHCard(rank: rank, suit: suit)
            }
        }
    }
}
