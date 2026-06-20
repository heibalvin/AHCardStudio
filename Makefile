SHELL := /bin/sh
SWIFTC ?= swiftc
XCODEBUILD ?= xcodebuild
BUILD_DIR := Build
HEADLESS := $(BUILD_DIR)/AHCardStudio
SOURCES := Source/AHCard.swift Source/AHCardDeck.swift Source/AHCardPack.swift Source/AHKlondike.swift Source/main.swift
APP_PROJECT := Applications/AHCardStudioiMacOS/AHCardStudioiMacOS.xcodeproj
APP_SCHEME := AHCardStudioiMacOS macOS
APP_DERIVED_DATA := $(BUILD_DIR)/AHCardStudioiMacOS
APP_BUNDLE := $(APP_DERIVED_DATA)/Build/Products/Debug/AHCardStudioiMacOS.app

.PHONY: all build run clean app app-build app-run app-clean

all: build

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(HEADLESS): $(SOURCES) | $(BUILD_DIR)
	$(SWIFTC) $(SOURCES) -o $(HEADLESS)

build: $(HEADLESS)

run: build
	./$(HEADLESS)

app app-build: $(APP_BUNDLE)

$(APP_BUNDLE): $(APP_PROJECT)
	$(XCODEBUILD) -project "$(APP_PROJECT)" -scheme "$(APP_SCHEME)" -configuration Debug -derivedDataPath "$(APP_DERIVED_DATA)" build

app-run: app
	open "$(APP_BUNDLE)"

clean:
	rm -rf $(BUILD_DIR)

app-clean:
	rm -rf $(APP_DERIVED_DATA)
