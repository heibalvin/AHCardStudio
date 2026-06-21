public protocol AHCardLike: Hashable {
    var rank: Int { get }
    var suit: Int { get }
    var isFolded: Bool { get set }
}

public enum AHCardDeckFoldPolicy {
    case fold
    case unfold
    case preserve
}

public enum AHCardDeckPopPolicy {
    case unfold
    case preserve
}

extension AHCard: AHCardLike {}

open class AHCardDeck<Card: AHCardLike>: CustomStringConvertible, Hashable {
    public var name: String
    public private(set) var cards: [Card]

    open var foldPolicy: AHCardDeckFoldPolicy {
        .preserve
    }

    open var popPolicy: AHCardDeckPopPolicy {
        .preserve
    }

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
        var pushedCard = preparePushedCard(card)
        switch foldPolicy {
        case .fold:
            pushedCard.isFolded = true
        case .unfold:
            pushedCard.isFolded = false
        case .preserve:
            break
        }
        cards.append(pushedCard)
    }

    public func pop() -> Card? {
        guard cards.isEmpty == false else {
            return nil
        }
        var poppedCard = preparePoppedCard(cards.remove(at: removeIndex))
        switch popPolicy {
        case .unfold:
            poppedCard.isFolded = false
        case .preserve:
            break
        }
        return poppedCard
    }

    public func reset() {
        cards.removeAll()
    }

    public func clear() {
        cards.removeAll()
    }

    public func getUnfoldedCards() -> [Card] {
        cards.filter { !$0.isFolded }
    }

    public func getTopUnfoldedCard() -> Card? {
        cards.last { !$0.isFolded }
    }

    public func getFirstUnfoldedIndex() -> Int? {
        cards.firstIndex { !$0.isFolded }
    }

    public func canStack(card: Card, on destination: AHCardDeck<Card>) -> Bool {
        guard let destinationCard = destination.getTopUnfoldedCard() else {
            return true
        }
        return card.suit == destinationCard.suit && destinationCard.rank == card.rank + 1
    }

    public func canStack(card: Card, onFoundation foundation: AHCardDeck<Card>) -> Bool {
        guard let foundationCard = foundation.getTopUnfoldedCard() else {
            return card.rank == 1
        }
        return card.suit == foundationCard.suit && foundationCard.rank == card.rank - 1
    }

    public func canMoveSegmentTo(_ destination: AHCardDeck<Card>, from index: Int) -> Bool {
        guard index >= 0 && index < cards.count else {
            return false
        }
        return destination.canStack(card: cards[index], on: destination)
    }

    public func moveSegmentTo(_ destination: AHCardDeck<Card>, from index: Int) -> Bool {
        guard index >= 0 && index < cards.count else {
            return false
        }
        let segment = Array(cards[index...])
        cards.removeSubrange(index...)
        destination.cards.append(contentsOf: segment)
        return true
    }

    public func pull(to destination: AHCardDeck<Card>, count: Int) -> Int {
        var pulled = 0
        while pulled < count {
            guard let card = pop() else {
                break
            }
            destination.push(card)
            pulled += 1
        }
        return pulled
    }

    public var description: String {
        "\(name): \(cards.map { "\($0)" }.joined(separator: " "))"
    }
}

open class AHCardDeckStock: AHCardDeck<AHCard> {
    override open var foldPolicy: AHCardDeckFoldPolicy {
        .fold
    }

    override open var popPolicy: AHCardDeckPopPolicy {
        .preserve
    }
}

open class AHCardDeckWaste: AHCardDeck<AHCard> {
    override open var removeIndex: Int {
        0
    }

    override open var foldPolicy: AHCardDeckFoldPolicy {
        .unfold
    }

    override open var popPolicy: AHCardDeckPopPolicy {
        .unfold
    }
}

open class AHCardDeckPile: AHCardDeck<AHCard> {
}
