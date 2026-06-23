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

enum AHCardDeckStacking {
    case grid
    case stacked
    case topdown
}

class AHCardDeck: CustomStringConvertible {
    var name: String
    var cards: [AHCard] = []
    var ordering: AHCardDeckOrdering
    var visibility: AHCardDeckVisibility
    var stacking: AHCardDeckStacking
    
    var description: String {
        // Map over the cards and join their descriptions together
        let cardsString = cards.map { $0.description }.joined(separator: " ")
        return "\(name) [\(cards.count) cards]: \(cardsString)"
    }
    
    init(name: String, visibility: AHCardDeckVisibility, ordering: AHCardDeckOrdering, stacking: AHCardDeckStacking) {
        self.name = name
        self.ordering = ordering
        self.visibility = visibility
        self.stacking = stacking
    }
    
    func setVisibility(_ visibility: AHCardDeckVisibility) {
        self.visibility = visibility
        if visibility == .allFolded {
            for card in cards {
                card.isVisible = false
            }
        } else if visibility == .allVisible {
            for card in cards {
                card.isVisible = true
            }
        }
    }
    
    func generate(_ type: AHCardDeckType) {
        reset()
        if type == .standard52one {
            for suit in 1...4 {
                // Loop 1 to 13 to stay safely within your AHCard bounds
                for rank in 1...13 {
                    let card = AHCard(rank: rank, suit: suit)
                    push([card])
                }
            }
        }
    }
    
    func reset() {
        cards = []
    }
    
    func push(_ lists: [AHCard]) {
        if ordering == .lilo {
            for card in lists {
                cards.append(card)
                if visibility == .allFolded {
                    card.isVisible = false
                } else if visibility == .allVisible {
                    card.isVisible = true
                }
            }
        }
    }
    
    func pop(_ number: Int = 1) -> [AHCard] {
        var lists = [AHCard]()
        for _ in 0...number-1 {
            if cards.count != 0 {
                lists.append(cards.removeLast())
            }
        }
        return lists
    }
    
    func shuffle() {
        cards.shuffle()
    }
    
    func sort() {
        cards.sort(by: { $0.id < $1.id })
    }
}

