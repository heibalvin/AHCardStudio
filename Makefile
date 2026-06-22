SHELL := /bin/sh
SWIFTC := swiftc
XCODEBUILD := xcodebuild
BUILD_DIR := Build

LIB_SOURCES := \
	Source/AHCardStudio/AHCard.swift \
	Source/AHCardStudio/AHCardDeck.swift \
	Source/AHCardStudio/AHKlondike.swift

LIB_OBJECTS := $(patsubst Source/AHCardStudio/%.swift,$(BUILD_DIR)/%.o,$(LIB_SOURCES))
LIB_LIBRARY := $(BUILD_DIR)/libAHCardStudioLib.a

TEST_SOURCES := $(LIB_SOURCES) Source/AHCardStudioTest/main.swift
TEST_EXEC := $(BUILD_DIR)/AHCardStudioTest

APP_PROJECT := Source/AHCardStudioiMacOS/AHCardStudioiMacOS.xcodeproj
APP_SCHEME ?= AHCardStudioiMacOS macOS
APP_DERIVED_DATA := Build/AHCardStudioiMacOS
APP_BUNDLE := $(APP_DERIVED_DATA)/Build/Products/Debug/AHCardStudioiMacOS.app

.PHONY: all lib app build run run-app clean app-clean test-build test-run app-build app-run lib-clean

all: run

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

lib: $(LIB_LIBRARY)

$(LIB_OBJECTS): $(LIB_SOURCES) | $(BUILD_DIR)
	cd $(BUILD_DIR) && $(SWIFTC) -emit-object $(addprefix ../,$(LIB_SOURCES))

$(LIB_LIBRARY): $(LIB_OBJECTS)
	libtool -static -o $@ $^

test-build: $(TEST_EXEC)

$(TEST_EXEC): $(TEST_SOURCES) | $(BUILD_DIR)
	$(SWIFTC) $(TEST_SOURCES) -o $(TEST_EXEC)

run: test-build
	@echo "--- Running Headless Game State Verification ---"
	./$(TEST_EXEC)

test-run: run

app: app-build

app-build: $(APP_BUNDLE)

$(APP_BUNDLE): $(APP_PROJECT) | $(BUILD_DIR)
	$(XCODEBUILD) -project "$(APP_PROJECT)" -scheme "$(APP_SCHEME)" -configuration Debug -derivedDataPath "$(APP_DERIVED_DATA)" build

app-run: app-build
	open "$(APP_BUNDLE)"

run-app: app-run

clean: lib-clean app-clean
	rm -rf $(BUILD_DIR)/* $(BUILD_DIR)/.DS_Store || true
	mkdir -p $(BUILD_DIR)

app-clean:
	rm -rf $(APP_DERIVED_DATA)

lib-clean:
	rm -f $(LIB_LIBRARY) $(LIB_OBJECTS)
