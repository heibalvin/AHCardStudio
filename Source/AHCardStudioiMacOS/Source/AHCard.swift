private let ranks = ["", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"]
private let suits = ["", "♦", "♣", "♥", "♠"]

public struct AHCard: CustomStringConvertible, Hashable, Codable {
    public var rank: Int
    public var suit: Int
    public var isFolded: Bool

    public init(rank: Int, suit: Int, isFolded: Bool = false) {
        self.rank = rank
        self.suit = suit
        self.isFolded = isFolded
    }

    public var isUnfolded: Bool {
        !isFolded
    }

    public var id: Int {
        suit * 14 + rank
    }

    public func folded() -> AHCard {
        var card = self
        card.isFolded = true
        return card
    }

    public func unfolded() -> AHCard {
        var card = self
        card.isFolded = false
        return card
    }

    public var description: String {
        isFolded ? ".." : "\(ranks[rank])\(suits[suit])"
    }
}
