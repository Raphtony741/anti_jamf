#!/bin/sh

# Run flutter doctor to check for any setup issues
flutter doctor

# Check the exit status of flutter doctor
if [ $? -ne 0 ]; then
  echo "Flutter setup is not correct. Please fix the issues above and try again."
  exit 1
fi
