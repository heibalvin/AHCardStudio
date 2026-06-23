import Foundation

class AHCard: CustomStringConvertible {
    static let ranks = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"]
    static let suits = ["♦️", "♣️", "♥️", "♠️"]
    
    var id: Int { suit * 14 + rank }
    var rank: Int 
    var suit: Int
    var isVisible: Bool
    
    init(rank: Int, suit: Int) {
        self.rank = rank
        self.suit = suit
        self.isVisible = false
    }
    
    var description: String {
        if !isVisible {
            return ".."
        }
        return "\(AHCard.ranks[rank-1])\(AHCard.suits[suit-1])"
    }
}