#!/bin/bash
bundle install && xcrun xcodebuild \
    -SYMROOT=build \
    -derivedDataPath build \
    ARCHS="i386 x86_64" \
    VALID_ARCHS="i386 x86_64" \
    ONLY_ACTIVE_ARCH=NO \
    -scheme "brasileirao-cal" \
    -sdk iphonesimulator \
    -configuration DEBUG \
    clean build