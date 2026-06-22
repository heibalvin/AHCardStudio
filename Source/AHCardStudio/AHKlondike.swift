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
        decks.append(AHCardDeck(name: "stock", visibility: .allFolded, ordering: .lilo))
        decks.append(AHCardDeck(name: "waste", visibility: .allVisible, ordering: .lilo))
        
        decks[0].generate(.standard52one)
    }
}