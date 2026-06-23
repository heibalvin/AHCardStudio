//
//  AHCardDeckView.swift
//  AHCardStudioApp
//
//  Created by Alvin HEIB on 23/06/2026.
//

import SwiftUI

struct AHCardDeckView: View {
    var deck: AHCardDeck
    var cardWidth: CGFloat
    
    var body: some View {
        if deck.stacking == .stacked {
            AHCardDeckStackedView(deck: deck, cardWidth: cardWidth)
        } else {
            // Fallback grid structure logic
            let columns = [GridItem(.fixed(cardWidth), spacing: 16)]
            ScrollView(.vertical) {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(deck.cards, id: \.id) { card in
                        AHCardView(card: card)
                            .frame(width: cardWidth)
                    }
                }
            }
        }
    }
}

