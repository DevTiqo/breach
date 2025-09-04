#!/bin/bash

set -e  # Exit immediately if a command fails

# Colors for logs
GREEN="\e[32m"
RED="\e[31m"
RESET="\e[0m"

echo -e "${GREEN}🚀 Starting Flutter build script...${RESET}"

# Clean old builds
echo -e "${GREEN}🧹 Cleaning project...${RESET}"
flutter clean
flutter pub get


TARGET=${1:-apk}   

case "$TARGET" in
  apk)
    echo -e "${GREEN}📦 Building Android APK...${RESET}"
    flutter build apk --release
    ;;
  appbundle)
    echo -e "${GREEN}📦 Building Android App Bundle (AAB)...${RESET}"
    flutter build appbundle --release
    ;;
  ios)
    echo -e "${GREEN}🍏 Building iOS IPA...${RESET}"
    flutter build ios --release --no-codesign
    ;;
  web)
    echo -e "${GREEN}🌐 Building Flutter Web...${RESET}"
    flutter build web --release
    ;;
  windows|linux|macos)
    echo -e "${GREEN}🖥️  Building Desktop app for $TARGET...${RESET}"
    flutter build $TARGET --release
    ;;
  *)
    echo -e "${RED}❌ Unknown target: $TARGET${RESET}"
    echo "Usage: ./build.sh [apk|appbundle|ios|web|windows|linux|macos]"
    exit 1
    ;;
esac

echo -e "${GREEN}✅ Build finished successfully!${RESET}"
