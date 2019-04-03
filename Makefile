TEMP_ZIP_DIR=./tmp/portable_zip
SWIFT_BIN_DIR=$(shell swift build -c release --show-bin-path)
BIN_NAME=acknowledgementsplist

.PHONY: project release_build portable_zip

project:
	swift package generate-xcodeproj

release_build:
	swift build -c release

portable_zip: release_build
	mkdir -p $(TEMP_ZIP_DIR)
	cp -f $(SWIFT_BIN_DIR)/$(BIN_NAME) $(TEMP_ZIP_DIR)
	cp -f LICENSE $(TEMP_ZIP_DIR)
	(cd $(TEMP_ZIP_DIR); zip -yr - $(BIN_NAME) LICENSE) > ./portable_acknowledgementsplist.zip
	rm -rf $(TEMP_ZIP_DIR)