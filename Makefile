SHELL := /bin/sh
SWIFTC := swiftc
XCODEBUILD := xcodebuild
BUILD_DIR := Build

LIB_SOURCES := \
	Source/AHCardStudioLib/AHCard.swift \
	Source/AHCardStudioLib/AHCardDeck.swift \
	Source/AHCardStudioLib/AHKlondike.swift

LIB_OBJECTS := $(patsubst Source/AHCardStudioLib/%.swift,$(BUILD_DIR)/%.o,$(LIB_SOURCES))
LIB_LIBRARY := $(BUILD_DIR)/libAHCardStudioLib.a

CONSOLE_SOURCES := $(LIB_SOURCES) Source/AHCardStudio/main.swift
CONSOLE_EXEC := $(BUILD_DIR)/AHCardStudio

APP_PROJECT := Source/AHCardStudioApp/AHCardStudioApp.xcodeproj
APP_SCHEME ?= AHCardStudioApp
APP_DERIVED_DATA := Build/AHCardStudioApp
APP_BUNDLE := $(APP_DERIVED_DATA)/Build/Products/$(APP_SCHEME)/AHCardStudioApp.app

.PHONY: all lib build run app-build app-run app-build-macos app-build-ios app-run-macos app-run-ios clean lib-clean app-clean

all: run

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

lib: $(LIB_LIBRARY)

$(LIB_OBJECTS): $(LIB_SOURCES) | $(BUILD_DIR)
	cd $(BUILD_DIR) && $(SWIFTC) -emit-object $(addprefix ../,$(LIB_SOURCES))

$(LIB_LIBRARY): $(LIB_OBJECTS)
	libtool -static -o $@ $^

build: $(CONSOLE_EXEC)

$(CONSOLE_EXEC): $(CONSOLE_SOURCES) | $(BUILD_DIR)
	$(SWIFTC) $(CONSOLE_SOURCES) -o $@

run: build
	./$(CONSOLE_EXEC)

app: app-build

app-build: $(APP_BUNDLE)

$(APP_BUNDLE): $(APP_PROJECT) | $(BUILD_DIR)
	$(XCODEBUILD) -project "$(APP_PROJECT)" -scheme "$(APP_SCHEME)" -configuration Debug -derivedDataPath "$(APP_DERIVED_DATA)" build

app-run: app-build
	open "$(APP_BUNDLE)"

app-build-macos: app-build
	$(MAKE) app-build APP_SCHEME=AHCardStudioApp

app-build-ios: app-build
	$(MAKE) app-build APP_SCHEME=AHCardStudioAppiOS

app-run-macos: app-build-macos
	$(MAKE) app-run APP_SCHEME=AHCardStudioApp

app-run-ios: app-build-ios
	xcrun simctl boot "iPhone 15" 2>/dev/null || true
	xcrun simctl install booted "$(APP_DERIVED_DATA)/Build/Products/Debug-iphonesimulator/AHCardStudioAppiOS.app"
	xcrun simctl launch booted com.heibalvin.AHCardStudioAppiOS

clean: lib-clean app-clean
	rm -rf $(BUILD_DIR)/* $(BUILD_DIR)/.DS_Store || true
	mkdir -p $(BUILD_DIR)

app-clean:
	rm -rf $(APP_DERIVED_DATA)

lib-clean:
	rm -f $(LIB_LIBRARY) $(LIB_OBJECTS)
