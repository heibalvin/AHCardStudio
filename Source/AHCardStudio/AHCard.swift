//
//  AHCard.swift
//  AHCardStudio
//
//  Created by Alvin HEIB on 21/06/2026.
//

import Foundation

class AHCard: CustomStringConvertible {
    static let suits = ["♦", "♣", "♥", "♠"]
    static let ranks = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"]
    
    var rank: Int
    var suit: Int
    var isVisible: Bool

    var description: String {
        isVisible ? "\(AHCard.ranks[rank - 1])\(AHCard.suits[suit - 1])" : ".."
    }
    
    var id: Int {
        return suit * 14 + rank
    }

    init(rank: Int, suit: Int, isVisible: Bool = false) {
        self.rank = rank
        self.suit = suit
        self.isVisible = isVisible
    }

    func getVisibility() -> Bool {
        return isVisible
    }

    func setVisibility(_ status: Bool) {
        isVisible = status
    }
}
