TEMP_ZIP_DIR=./tmp/portable_zip
SWIFT_BIN_DIR=$(shell swift build -c release --show-bin-path)
BIN_NAME=acknowledgementsplist

.PHONY: portable_zip

portable_zip:
	swift build -c release --static-swift-stdlib
	mkdir -p $(TEMP_ZIP_DIR)
	cp -f $(SWIFT_BIN_DIR)/$(BIN_NAME) $(TEMP_ZIP_DIR)
	cp -f LICENSE $(TEMP_ZIP_DIR)
	(cd $(TEMP_ZIP_DIR); zip -yr - $(BIN_NAME) LICENSE) > ./portable_swiftlint.zip
	rm -rf $(TEMP_ZIP_DIR)