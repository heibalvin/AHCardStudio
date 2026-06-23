//
//  AHCardDeckStackedView.swift
//  AHCardStudioApp
//
//  Created by Alvin HEIB on 23/06/2026.
//


import SwiftUI

struct AHCardDeckStackedView: View {
    var deck: AHCardDeck
    var cardWidth: CGFloat
    
    // Configurable 1px increment displacement offset per card
    let offsetXIncrement: CGFloat = 0.20
    let offsetYIncrement: CGFloat = 0.20
    
    var body: some View {
        ZStack {
            // Base placeholder if the deck runs completely empty
            RoundedRectangle(cornerRadius: cardWidth * 0.15)
                .strokeBorder(Color.white.opacity(0.2), lineWidth: 2)
                .frame(width: cardWidth, height: cardWidth * 1.357)
            
            // Render stacked cards sequentially
            ForEach(0..<deck.cards.count, id: \.self) { index in
                let card = deck.cards[index]
                let currentOffset = CGFloat(index)
                
                AHCardView(card: card)
                    .frame(width: cardWidth)
                    .offset(
                        x: currentOffset * offsetXIncrement,
                        y: currentOffset * offsetYIncrement
                    )
                // Ensuring the top card gets visual superiority
                    .zIndex(Double(index))
            }
        }
        .frame(width: cardWidth, height: cardWidth * 1.357)
    }
}
