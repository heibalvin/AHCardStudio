//
//  AHKlondike.swift
//  AHCardStudio
//
//  Created by Alvin HEIB on 21/06/2026.
//

import Foundation

class AHKlondike: CustomStringConvertible {
    var decks = [AHCardDeck]()
    
    var description: String {
        var str = "Klondike:\n"
        for deck in decks {
            str += "\(deck)\n"
        }
        return str
    }
    
    init() {
        decks.append(AHCardDeck(name: "stock", visibility: .allFolded, policy: .lilo))
        decks.append(AHCardDeck(name: "waste", visibility: .allVisible, policy: .lilo))
        
        decks[0].generate(.standard52one)
    }
    
    
}

/*
public enum AHKlondikeAIMove: CustomStringConvertible {
    case pulledStock(Int)
    case stackedWasteToPile(Int)
    case stackedPileToFoundation(Int, Int)
    case movedPile(Int, Int)
    case won
    case noMove

    public var description: String {
        switch self {
        case .pulledStock(let count):
            return "Pulled \(count) stock card(s) to waste"
        case .stackedWasteToPile(let pileIndex):
            return "Stacked waste to pile \(pileIndex + 1)"
        case .stackedPileToFoundation(let pileIndex, let foundationIndex):
            return "Stacked pile \(pileIndex + 1) to foundation \(foundationIndex + 1)"
        case .movedPile(let sourceIndex, let destinationIndex):
            return "Moved pile \(sourceIndex + 1) to pile \(destinationIndex + 1)"
        case .won:
            return "Won"
        case .noMove:
            return "No move"
        }
    }
}

public struct AHKlondike: CustomStringConvertible {
    public var stock: AHCardDeckStock
    public var waste: AHCardDeckWaste
    public var foundations: [AHCardDeckPile]
    public var piles: [AHCardDeckPile]

    public init() {
        self.init(cards: AHCardPack.standard52oneCards().shuffled())
    }

    public init(cards: [AHCard]) {
        var shuffledCards = cards
        var foundations: [AHCardDeckPile] = []
        var piles: [AHCardDeckPile] = []

        for foundationIndex in 0..<4 {
            foundations.append(AHCardDeckPile(name: "Foundation \(foundationIndex + 1)"))
        }

        for pileIndex in 0..<7 {
            piles.append(AHCardDeckPile(name: "Pile \(pileIndex + 1)"))
        }

        for pileIndex in 0..<7 {
            for cardIndex in 0...pileIndex {
                var card = shuffledCards.removeFirst()
                card.isFolded = cardIndex != pileIndex
                piles[pileIndex].push(card)
            }
        }

        let stockCards = shuffledCards.map { card -> AHCard in
            var foldedCard = card
            foldedCard.isFolded = true
            return foldedCard
        }

        self.stock = AHCardDeckStock(name: "Stock", cards: stockCards)
        self.waste = AHCardDeckWaste(name: "Waste")
        self.foundations = foundations
        self.piles = piles
    }

    public mutating func drawStockToWaste() {
        guard let card = stock.pop() else {
            return
        }

        waste.push(card)
    }

    public mutating func recycleWasteToStock() {
        while let card = waste.pop() {
            stock.push(card)
        }
    }

    public var isWon: Bool {
        stock.cards.isEmpty && waste.cards.isEmpty && piles.allSatisfy { $0.cards.isEmpty }
    }

    public mutating func pullStock(count: Int = 3) -> Bool {
        stock.pull(to: waste, count: count) > 0
    }

    public mutating func stackWasteToPile(_ pileIndex: Int) -> Bool {
        guard pileIndex >= 0 && pileIndex < piles.count else {
            return false
        }
        guard let card = waste.cards.first else {
            return false
        }
        guard piles[pileIndex].canStack(card: card, on: piles[pileIndex]) else {
            return false
        }
        guard let movedCard = waste.pop() else {
            return false
        }
        piles[pileIndex].push(movedCard)
        return true
    }

    public mutating func stackPileToFoundation(_ pileIndex: Int) -> Bool {
        guard pileIndex >= 0 && pileIndex < piles.count else {
            return false
        }
        guard let card = piles[pileIndex].getTopUnfoldedCard() else {
            return false
        }
        guard let foundationIndex = foundationIndex(for: card, pileIndex: pileIndex) else {
            return false
        }
        guard piles[pileIndex].pop() != nil else {
            return false
        }
        foundations[foundationIndex].push(card)
        return true
    }

    public mutating func movePile(_ sourceIndex: Int, to destinationIndex: Int) -> Bool {
        guard sourceIndex >= 0 && sourceIndex < piles.count else {
            return false
        }
        guard destinationIndex >= 0 && destinationIndex < piles.count else {
            return false
        }
        guard sourceIndex != destinationIndex else {
            return false
        }
        guard let firstUnfoldedIndex = piles[sourceIndex].getFirstUnfoldedIndex() else {
            return false
        }
        guard piles[sourceIndex].canMoveSegmentTo(piles[destinationIndex], from: firstUnfoldedIndex) else {
            return false
        }
        return piles[sourceIndex].moveSegmentTo(piles[destinationIndex], from: firstUnfoldedIndex)
    }

    public mutating func stepAI() -> AHKlondikeAIMove {
        if isWon {
            return .won
        }

        for pileIndex in piles.indices {
            if let card = piles[pileIndex].getTopUnfoldedCard(),
               let foundationIndex = foundationIndex(for: card, pileIndex: pileIndex),
               stackPileToFoundation(pileIndex) {
                return .stackedPileToFoundation(pileIndex, foundationIndex)
            }
        }

        for sourceIndex in piles.indices {
            for destinationIndex in piles.indices where sourceIndex != destinationIndex {
                if movePile(sourceIndex, to: destinationIndex) {
                    return .movedPile(sourceIndex, destinationIndex)
                }
            }
        }

        for pileIndex in piles.indices {
            if stackWasteToPile(pileIndex) {
                return .stackedWasteToPile(pileIndex)
            }
        }

        let pulled = stock.pull(to: waste, count: 3)
        if pulled > 0 {
            return .pulledStock(pulled)
        }

        return .noMove
    }

    private func foundationIndex(for card: AHCard, pileIndex: Int) -> Int? {
        foundations.firstIndex { foundation in
            piles[pileIndex].canStack(card: card, onFoundation: foundation)
        }
    }

    public var description: String {
        var lines: [String] = [
            "AHKlondike:",
            stock.description,
            waste.description
        ]

        for foundation in foundations {
            lines.append(foundation.description)
        }

        for pile in piles {
            lines.append(pile.description)
        }

        return lines.joined(separator: "\n")
    }
}
*/
