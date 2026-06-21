SHELL := /bin/sh
SWIFTC ?= swiftc
XCODEBUILD ?= xcodebuild
CXX ?= c++
CXXFLAGS ?= -std=c++17 -Wall -Wextra
BUILD_DIR := Build
HEADLESS := $(BUILD_DIR)/AHCardStudio
AIPLAYER_OBJ := $(BUILD_DIR)/aiplayer.o
SOURCES := Source/AHCard.swift Source/AHCardDeck.swift Source/AHCardPack.swift Source/AHKlondike.swift Source/main.swift
PROJECT ?= Applications/AHCardStudioiMacOS/AHCardStudioiMacOS.xcodeproj
APP_SCHEME ?= AHCardStudioiMacOS macOS
APP_BUILD_DIR ?= Build/AHCardStudioiMacOS
APP_DERIVED_DATA := $(APP_BUILD_DIR)
APP_BUNDLE := $(APP_DERIVED_DATA)/Build/Products/Debug/AHCardStudioiMacOS.app

.PHONY: all build run clean app app-build app-run app-clean aiplayer aiplayer-clean

all: build

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(HEADLESS): $(SOURCES) | $(BUILD_DIR)
	$(SWIFTC) $(SOURCES) -o $(HEADLESS)

$(AIPLAYER_OBJ): Source/aiplayer.cpp | $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) -c $< -o $@

build: $(HEADLESS)

aiplayer: $(AIPLAYER_OBJ)

run: build
	./$(HEADLESS)

app app-build: $(APP_BUNDLE)

$(APP_BUNDLE): $(PROJECT)
	$(XCODEBUILD) -project "$(PROJECT)" -scheme "$(APP_SCHEME)" -configuration Debug -derivedDataPath "$(APP_DERIVED_DATA)" build

app-run: app
	open "$(APP_BUNDLE)"

clean:
	rm -rf $(BUILD_DIR)

app-clean:
	rm -rf $(APP_DERIVED_DATA)

aiplayer-clean:
	rm -f $(AIPLAYER_OBJ)
