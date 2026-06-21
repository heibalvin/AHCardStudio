# AHCardStudio

AHCardStudio is a Swift / SpriteKit game library for running games like Poker, BlackJack, Hearts, FreeCell, and more on iOS and macOS. The project is designed to support headless AI / reinforcement-learning form factors and windowed visual-game form factors.

## Current headless layout

- `Source/` contains Swift source files.
- `Build/` contains compiled headless executables.
- `Assets/` is reserved for game assets.
- `Assets/boardgame-pack/` contains Kenney.nl board game assets from [OpenGameArt: Boardgame Pack](https://opengameart.org/content/boardgame-pack).

## First headless executable

The first headless version defines:

- `AHCard.rank: Int` from `1` to `14`, where `14` is Ace.
- `AHCard.suit: Int` from `1` to `4`, ordered as `Diamond`, `Club`, `Heart`, `Spade`.
- `AHCard.id`, calculated as `suit * 14 + rank`.
- `AHCard(rank:suit:isFolded:)`.
- `AHCardDeck<Card>`, renamed from `AHDeck`, with generic `push(_:)` and `pop()` behavior.
- `AHCardDeckStock`, `AHCardDeckWaste`, and `AHCardDeckPile` inherit from `AHCardDeck<AHCard>`.
- `AHCardPack.standard52()`, which creates a 52-card pack using ranks `2` through `A`.
- `AHCardPack.standard52one()`, which creates a Klondike 52-card pack using ranks `1` through `K`.
- `AHKlondike`, which creates a stock, waste deck, 4 foundations, and 7 tableau piles.

## Build and run

Build the headless executable:

```sh
make build
```

Run the headless executable:

```sh
make run
```

`make run` builds `Build/AHCardStudio` and prints the Klondike layout to the console.

Build the macOS SpriteKit app:

```sh
make app-build
```

Build and open the macOS SpriteKit app:

```sh
make app-run
```

`make app-run` builds `Applications/AHCardStudioiMacOS/AHCardStudioiMacOS.xcodeproj` with the `AHCardStudioiMacOS macOS` scheme and opens `Build/AHCardStudioiMacOS/Build/Products/Debug/AHCardStudioiMacOS.app`.

## Clean

Clean the headless build output:

```sh
make clean
```

Clean the macOS app build output:

```sh
make app-clean
```
