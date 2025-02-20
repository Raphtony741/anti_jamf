#!/bin/sh

# Check if running on Windows
if [ "$(expr substr $(uname -s) 1 5)" = "MINGW" ] || [ "$(expr substr $(uname -s) 1 5)" = "MSYS" ]; then
    # Check environment first
    powershell.exe -ExecutionPolicy Bypass -File check_environment.ps1
    if [ $? -ne 0 ]; then
        echo "Environment check failed. Please fix the issues and try again."
        exit 1
    fi
fi

# Remove build and temporary directories
rm -rf build/
rm -rf .dart_tool/
rm -rf windows/flutter/ephemeral/

# Clean Flutter project
flutter clean

# Delete pubspec.lock to force fresh dependency resolution
rm -f pubspec.lock

# Get packages fresh
flutter pub get

# Rebuild Flutter plugins
flutter pub cache repair
flutter pub run flutter_tools:main
