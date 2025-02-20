#!/bin/sh

# First check the environment
./check_environment.sh
if [ $? -ne 0 ]; then
    exit 1
fi

# Run flutter doctor with verbose output
flutter doctor -v

# Check the exit status
if [ $? -ne 0 ]; then
    echo "\nTroubleshooting tips:"
    echo "1. Make sure Visual Studio is installed with 'Desktop development with C++'"
    echo "2. Try running 'flutter config --enable-windows-desktop'"
    echo "3. Check that Android Studio is properly installed if building for mobile"
    exit 1
fi
