//
//  AHKlondikeView.swift
//  AHCardStudioApp
//
//  Created by Alvin HEIB on 23/06/2026.
//

import SwiftUI

struct AHKlondikeView: View {
    let darkGreen = Color(red: 0.05, green: 0.35, blue: 0.15)
    let spacing: CGFloat = 12
    
    // Instantiate your engine class instance as a state object
    @State private var game = AHKlondike()
    
    var body: some View {
        GeometryReader { geometry in
            // Calculate 7 columns across the board width boundary budget
            let totalSpacing = spacing * 8
            let cardWidth = (geometry.size.width - totalSpacing) / 7
            
            ZStack {
                darkGreen
                    .ignoresSafeArea()
                
                VStack(alignment: .leading, spacing: 20) {
                    
                    // --- TOP DASHBOARD ROW ---
                    HStack(spacing: spacing) {
                        
                        // 1. Stock Deck (Index 0)
                        if let stockDeck = game.decks["stock"] {
                            VStack(alignment: .center, spacing: 4) {
                                AHCardDeckView(deck: stockDeck, cardWidth: cardWidth)
                                Text("Stock (\(stockDeck.cards.count))")
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.7))
                            }
                        }
                        
                        // 2. Waste Deck (Index 1)
                        if let wasteDeck = game.decks["waste"] {
                            VStack(alignment: .center, spacing: 4) {
                                AHCardDeckView(deck: wasteDeck, cardWidth: cardWidth)
                                Text("Waste (\(wasteDeck.cards.count))")
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.7))
                            }
                        }
                        
                        // Pushes the deck components to the top-left corner
                        Spacer()
                    }
                    .padding([.top, .leading], spacing)
                    
                    // --- MAIN ENGINE STATE DISPLAY ---
                    Spacer()
                }
            }
        }
    }
}

