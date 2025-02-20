#!/bin/sh

# Skip environment checks if running in CI
if [ -z "$CM_BUILD_ID" ]; then
    ./flutter_doctor.sh
    if [ $? -ne 0 ]; then
        exit 1
    fi
fi

# Check for outdated dependencies
flutter pub outdated

# Update dependencies
flutter pub upgrade
