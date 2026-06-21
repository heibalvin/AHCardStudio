public protocol AHCardLike: Hashable {
    var isFolded: Bool { get set }
}

extension AHCard: AHCardLike {}

open class AHCardDeck<Card: AHCardLike>: CustomStringConvertible, Hashable {
    public var name: String
    public private(set) var cards: [Card]

    public init(name: String, cards: [Card] = []) {
        self.name = name
        self.cards = cards
    }

    public static func == (lhs: AHCardDeck<Card>, rhs: AHCardDeck<Card>) -> Bool {
        lhs.name == rhs.name && lhs.cards == rhs.cards
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(cards)
    }

    open var removeIndex: Int {
        cards.count - 1
    }

    open func preparePushedCard(_ card: Card) -> Card {
        card
    }

    open func preparePoppedCard(_ card: Card) -> Card {
        card
    }

    public func push(_ card: Card) {
        cards.append(preparePushedCard(card))
    }

    public func pop() -> Card? {
        guard cards.isEmpty == false else {
            return nil
        }
        return preparePoppedCard(cards.remove(at: removeIndex))
    }

    public func reset() {
        cards.removeAll()
    }

    public func clear() {
        cards.removeAll()
    }

    public var description: String {
        "\(name): \(cards.map { "\($0)" }.joined(separator: " "))"
    }
}

open class AHCardDeckStock: AHCardDeck<AHCard> {
    override open func preparePushedCard(_ card: AHCard) -> AHCard {
        var pushedCard = card
        pushedCard.isFolded = true
        return pushedCard
    }
}

open class AHCardDeckWaste: AHCardDeck<AHCard> {
    override open var removeIndex: Int {
        0
    }

    override open func preparePushedCard(_ card: AHCard) -> AHCard {
        var pushedCard = card
        pushedCard.isFolded = false
        return pushedCard
    }

    override open func preparePoppedCard(_ card: AHCard) -> AHCard {
        var poppedCard = card
        poppedCard.isFolded = false
        return poppedCard
    }
}

open class AHCardDeckPile: AHCardDeck<AHCard> {
}
