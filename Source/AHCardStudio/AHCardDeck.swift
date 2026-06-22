import Foundation

enum AHCardDeckType {
    case standard52one
}

enum AHCardDeckOrdering {
    case lilo // Last In, Last Out (Queue behavior)
}

enum AHCardDeckVisibility {
    case allVisible
    case allFolded
}

class AHCardDeck: CustomStringConvertible {
    var name: String
    var cards: [AHCard] = []
    var ordering: AHCardDeckOrdering
    var visibility: AHCardDeckVisibility
    
    var description: String {
        let cardsString = cards.map { $0.description }.joined(separator: " ")
        return "\(name) (\(cards.count)): \(cardsString)"
    }
    
    init(name: String, visibility: AHCardDeckVisibility, ordering: AHCardDeckOrdering) {
        self.name = name
        self.ordering = ordering
        self.visibility = visibility
    }
    
    func generate(_ type: AHCardDeckType) {
        reset()
        if type == .standard52one {
            for suit in 1...4 {
                for rank in 1...13 {
                    let card = AHCard(rank: rank, suit: suit)
                    push(card)
                }
            }
        }
    }
    
    func reset() {
        cards = []
    }
    
    func setVisibility(_ newVisibility: AHCardDeckVisibility) {
        self.visibility = newVisibility
        for card in cards {
            card.isVisible = (newVisibility == .allVisible)
        }
    }
    
    func push(_ card: AHCard) {
        if ordering == .lilo {
            cards.append(card)
        }
        
        if visibility == .allFolded {
            card.isVisible = false
        } else if visibility == .allVisible {
            card.isVisible = true
        }
    }
    
    func pop() -> AHCard? {
        if !cards.isEmpty {
            return cards.removeLast()
        }
        return nil
    }
    
    func shuffle() {
        cards.shuffle()
    }
    
    func sort() {
        cards.sort(by: { $0.id < $1.id })
    }
}