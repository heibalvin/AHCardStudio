# AHCardStudio

AHCardStudio is a Swift / SpriteKit game library for running games like Poker, BlackJack, Hearts, FreeCell, and more on iOS and macOS. The project is designed to support headless AI / reinforcement-learning form factors and windowed visual-game form factors.

## Project layout

- `Source/AHCardStudioLib/` — core library (card, deck, and Klondike model).
- `Source/AHCardStudio/` — headless executable that exercises the library.
- `Source/AHCardStudioApp/` — SwiftUI app (Xcode project, macOS + iOS targets).
- `Build/` — compiled `.o` and `.a` library artifacts, executable binaries, and app build products.
- `Assets/` — game card PNG assets and board graphics.

## Build and run

Build and run the headless executable (`AHCardStudio`):

```sh
make            # or: make run
```

Build only the headless executable without running it:

```sh
make build
```

Build the static library (`libAHCardStudioLib.a` + object files):

```sh
make lib
```

Build the macOS SwiftUI app:

```sh
make app-build-macos   # or: make app-build (defaults to macOS)
```

Build and run the macOS SwiftUI app:

```sh
make app-run-macos     # or: make app-run (defaults to macOS)
```

Build the iOS SwiftUI app:

```sh
make app-build-ios
```

Run the iOS SwiftUI app on the simulator:

```sh
make app-run-ios
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
