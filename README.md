# AHCardStudio

AHCardStudio is a Swift / SpriteKit game library for running games like Poker, BlackJack, Hearts, FreeCell, and more on iOS and macOS. The project is designed to support headless AI / reinforcement-learning form factors and windowed visual-game form factors.

## Project layout

- `Source/AHCardStudio/` — core library (card, deck, and Klondike model).
- `Source/AHCardStudioTest/` — headless executable that exercises the library.
- `Source/AHCardStudioiMacOS/` — macOS SpriteKit app (Xcode project).
- `Build/` — compiled `.o` and `.a` library artifacts, test binaries, and app build products.
- `Assets/` — game card PNG assets and board graphics.

## Build and run

Build and run the headless test executable (`AHCardStudioTest`):

```sh
make            # or: make run
```

Build only the headless test executable without running it:

```sh
make test-build
```

Build the static library (`libAHCardStudioLib.a` + `AHCardStudioLib.o`):

```sh
make lib
```

Build the macOS SpriteKit app:

```sh
make app       # or: make app-build
```

Build and open the macOS SpriteKit app:

```sh
make run-app   # or: make app-run
```

## Clean

Remove all build output:

```sh
make clean
```

Remove only the app-derived data:

```sh
make app-clean
```

Remove only the library build artifacts (`.o` / `.a`):

```sh
make lib-clean
```
