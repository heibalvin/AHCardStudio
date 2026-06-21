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
