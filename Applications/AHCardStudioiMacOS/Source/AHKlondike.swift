public struct AHKlondike: CustomStringConvertible {
    public var stock: AHCardDeck
    public var waste: AHCardDeck
    public var foundations: [AHCardDeck]
    public var piles: [AHCardDeck]

    public init() {
        self.init(cards: AHCardPack.standard52oneCards().shuffled())
    }

    public init(cards: [AHCard]) {
        var shuffledCards = cards
        var foundations: [AHCardDeck] = []
        var piles: [AHCardDeck] = []

        for foundationIndex in 0..<4 {
            foundations.append(AHCardDeck.pile(name: "Foundation \(foundationIndex + 1)"))
        }

        for pileIndex in 0..<7 {
            piles.append(AHCardDeck.pile(name: "Pile \(pileIndex + 1)"))
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

        self.stock = AHCardDeck.stock(name: "Stock", cards: stockCards)
        self.waste = AHCardDeck.waste(name: "Waste")
        self.foundations = foundations
        self.piles = piles
    }

    public mutating func drawStockToWaste() {
        guard let card = stock.pop() else {
            return
        }

        var wasteCard = card
        wasteCard.isFolded = false
        waste.push(wasteCard)
    }

    public mutating func recycleWasteToStock() {
        while let card = waste.pop() {
            var stockCard = card
            stockCard.isFolded = true
            stock.push(stockCard)
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
