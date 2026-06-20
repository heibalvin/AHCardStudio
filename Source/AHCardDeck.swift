public enum AHCardDeckType: Int, CustomStringConvertible, Codable {
    case stock = 1
    case waste = 2
    case pile = 3

    public var description: String {
        switch self {
        case .stock:
            return "stock"
        case .waste:
            return "waste"
        case .pile:
            return "pile"
        }
    }

    public var isLIFO: Bool {
        switch self {
        case .stock, .pile:
            return true
        case .waste:
            return false
        }
    }

    public var shouldFoldPushedCard: Bool {
        switch self {
        case .stock:
            return true
        case .waste, .pile:
            return false
        }
    }

    public var shouldUnfoldPoppedCard: Bool {
        switch self {
        case .stock:
            return false
        case .waste, .pile:
            return true
        }
    }
}

public struct AHCardDeck: CustomStringConvertible, Hashable, Codable {
    public var name: String
    public var type: AHCardDeckType
    public private(set) var cards: [AHCard]

    public init(name: String, type: AHCardDeckType, cards: [AHCard]? = nil) {
        self.name = name
        self.type = type
        self.cards = cards ?? []
    }

    public static func stock(name: String = "Stock", cards: [AHCard]? = nil) -> AHCardDeck {
        AHCardDeck(name: name, type: .stock, cards: cards)
    }

    public static func waste(name: String = "Waste", cards: [AHCard]? = nil) -> AHCardDeck {
        AHCardDeck(name: name, type: .waste, cards: cards)
    }

    public static func pile(name: String = "Pile", cards: [AHCard]? = nil) -> AHCardDeck {
        AHCardDeck(name: name, type: .pile, cards: cards)
    }

    public mutating func reset() {
        cards.removeAll()
    }

    public mutating func clear() {
        cards.removeAll()
    }

    public mutating func push(_ card: AHCard) {
        var pushedCard = card
        if type.shouldFoldPushedCard {
            pushedCard.isFolded = true
        } else if type == .waste {
            pushedCard.isFolded = false
        }
        cards.append(pushedCard)
    }

    public mutating func pop() -> AHCard? {
        guard cards.isEmpty == false else {
            return nil
        }

        let index = type.isLIFO ? cards.count - 1 : 0
        var poppedCard = cards.remove(at: index)
        if type.shouldUnfoldPoppedCard {
            poppedCard.isFolded = false
        }
        return poppedCard
    }

    public var description: String {
        "\(name): \(cards.map { "\($0)" }.joined(separator: " "))"
    }
}
