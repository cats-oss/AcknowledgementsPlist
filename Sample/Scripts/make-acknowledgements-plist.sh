#!/bin/bash

PROJECT_ROOT_PATH=./..
ACK_PLIST_EXE=${PROJECT_ROOT_PATH}/Pods/AcknowledgementsPlist/AcknowledgementsPlist
OUTPUT_PLIST_PATH=./Sample/Resources/Sample-Acknowledgements.plist
OUTPUT_BUNDLE_PATH=./Sample/Resources/Settings.bundle
MANUAL_ACK_PATH=./Sample/Resources/ManualAcknowledgements.plist
EXCLUDE_STRING="NSObject-Rx RxOptional"

# make plist
$ACK_PLIST_EXE $PROJECT_ROOT_PATH $OUTPUT_PLIST_PATH --manual-plist-path $MANUAL_ACK_PATH --exclude-string "${EXCLUDE_STRING}"

# make bundle
$ACK_PLIST_EXE $PROJECT_ROOT_PATH  $OUTPUT_BUNDLE_PATH --manual-plist-path $MANUAL_ACK_PATH --exclude-string "${EXCLUDE_STRING}"
