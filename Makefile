TEMP_ZIP_DIR=./tmp/portable_zip
SWIFT_BIN_DIR=$(shell swift build -c release --show-bin-path)
BIN_NAME=acknowledgementsplist

# refer: https://github.com/realm/SwiftLint/pull/2682
SWIFT_BUILD_FLAGS=-c release
UNAME=$(shell uname)
ifeq ($(UNAME), Darwin)
USE_SWIFT_STATIC_STDLIB:=$(shell test -d $$(dirname $$(xcrun --find swift))/../lib/swift_static/macosx && echo yes)
ifeq ($(USE_SWIFT_STATIC_STDLIB), yes)
SWIFT_BUILD_FLAGS+= -Xswiftc -static-stdlib
endif
endif

TEMP_ZIP_DIR=./tmp/portable_zip
SWIFT_BIN_DIR=$(shell swift build $(SWIFT_BUILD_FLAGS) --show-bin-path)
BIN_NAME=acknowledgementsplist

.PHONY: project release_build portable_zip

project:
	swift package generate-xcodeproj

release_build:
	swift build $(SWIFT_BUILD_FLAGS)

portable_zip: release_build
	mkdir -p $(TEMP_ZIP_DIR)
	cp -f $(SWIFT_BIN_DIR)/$(BIN_NAME) $(TEMP_ZIP_DIR)
	cp -f LICENSE $(TEMP_ZIP_DIR)
	(cd $(TEMP_ZIP_DIR); zip -yr - $(BIN_NAME) LICENSE) > ./portable_acknowledgementsplist.zip
	rm -rf $(TEMP_ZIP_DIR)
