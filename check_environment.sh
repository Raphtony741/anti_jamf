#!/bin/sh

# Check if running in Codemagic
if [ -n "$CM_BUILD_ID" ]; then
    echo "Running in Codemagic CI environment"
    # Codemagic handles Flutter setup automatically
    exit 0
fi

# For local development, check Flutter setup
if [ -z "$FLUTTER_ROOT" ]; then
    echo "Error: FLUTTER_ROOT is not set"
    echo "Please set the FLUTTER_ROOT environment variable to your Flutter SDK path"
    exit 1
fi

# Check if Flutter is in PATH
if ! command -v flutter &> /dev/null; then
    echo "Error: Flutter command not found in PATH"
    echo "Please add Flutter to your PATH"
    exit 1
fi

echo "Environment check passed!"
