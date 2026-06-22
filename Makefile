SHELL := /bin/sh
SWIFTC := swiftc
XCODEBUILD := xcodebuild
BUILD_DIR := Build

LIB_SOURCES := \
	Source/AHCardStudio/AHCard.swift \
	Source/AHCardStudio/AHCardDeck.swift \
	Source/AHCardStudio/AHKlondike.swift

# Headless Test Executable
TEST_EXEC := $(BUILD_DIR)/AHCardStudioTest
TEST_SOURCES := $(LIB_SOURCES) Source/AHCardStudioTest/main.swift

# macOS App Configuration
APP_PROJECT := Source/AHCardStudioiMacOS/AHCardStudioiMacOS.xcodeproj
APP_SCHEME ?= AHCardStudioiMacOS macOS
APP_DERIVED_DATA := Build/AHCardStudioiMacOS
APP_BUNDLE := $(APP_DERIVED_DATA)/Build/Products/Debug/AHCardStudioiMacOS.app

.PHONY: all build run clean app-build app-run app-clean test-build test-run

# Default target: Builds everything (Lib, Headless Test, and macOS App)
all: build app-build

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

# Builds the headless test binary
test-build: $(TEST_EXEC)

$(TEST_EXEC): $(TEST_SOURCES) | $(BUILD_DIR)
	$(SWIFTC) $(TEST_SOURCES) -o $(TEST_EXEC)

# Runs the headless simulation by default
run: test-run

test-run: test-build
	@echo "--- Running Headless Game State Verification ---"
	./$(TEST_EXEC)

# macOS App Targets
app-build: $(APP_BUNDLE)

$(APP_BUNDLE): $(APP_PROJECT)
	$(XCODEBUILD) -project "$(APP_PROJECT)" -scheme "$(APP_SCHEME)" -configuration Debug -derivedDataPath "$(APP_DERIVED_DATA)" build

app-run: app-build
	open "$(APP_BUNDLE)"

# Cleaners
clean: app-clean
	rm -rf $(BUILD_DIR)

app-clean:
	rm -rf $(APP_DERIVED_DATA)