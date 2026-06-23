import Foundation

class AHKlondike: CustomStringConvertible {
    var decks = [String: AHCardDeck]()
    
    var description: String {
        var str = "AHKlondike:\n"
        for deck in decks {
            str += "\(deck)\n"
        }
        return str
    }
    
    init() {
        decks["stock"] = AHCardDeck(name: "stock", visibility: .allFolded, ordering: .lilo, stacking: .stacked)
        decks["stock"]!.generate(.standard52one)
        decks["waste"] = AHCardDeck(name: "waste", visibility: .allVisible, ordering: .lilo, stacking: .stacked)
        
        for id in 0...3 {
            decks["foundation\(id)"] = AHCardDeck(name: "foundation\(id)", visibility: .allVisible, ordering: .lilo, stacking: .stacked)
        }
        
        for id in 0...6 {
            decks["pile\(id)"] = AHCardDeck(name: "pile\(id)", visibility: .allVisible, ordering: .lilo, stacking: .topdown)
        } 
    }
    
    func actionPullStock() {
        let lists = decks["stock"]!.pop(3)
        decks["waste"]!.push(lists)
    }
    /*
    func actionPush
    */
}
