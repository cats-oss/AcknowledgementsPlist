#!/bin/bash

PROJECT_ROOT_PATH=./../..
OUTPUT_PLIST_PATH=./Sample/Resources/Sample-Acknowledgements.plist
OUTPUT_BUNDLE_PATH=./Sample/Resources/Settings.bundle
MANUAL_ACKNOWLEDGEMENTS_PATH=./Sample/Resources/ManualAcknowledgements.plist

# make plist
./AcknowledgementsPlist $PROJECT_ROOT_PATH $OUTPUT_PLIST_PATH --manual-plist-path $MANUAL_ACKNOWLEDGEMENTS_PATH

# make bundle
./AcknowledgementsPlist $PROJECT_ROOT_PATH  $OUTPUT_BUNDLE_PATH --manual-plist-path $MANUAL_ACKNOWLEDGEMENTS_PATH
