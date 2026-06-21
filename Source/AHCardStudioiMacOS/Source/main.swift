var klondike = AHKlondike()
print(klondike.description)

for step in 1...25 {
    if klondike.isWon {
        break
    }

    let move = klondike.stepAI()
    print("\nStep \(step): \(move)")
    print(klondike.description)

    if case .noMove = move {
        break
    }
}
