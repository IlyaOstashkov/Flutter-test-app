#!/bin/sh

CURRENT_DIR=$(dirname "$0")
PACKAGES_DIR="packages"
TEST_DIR="test"

cd "$CURRENT_DIR/.."
echo "Testing the app"
fvm flutter test

cd $PACKAGES_DIR

for d in $(ls); do
    if [ -d "$d/$TEST_DIR" ]; then
        echo "Testing $d"
        cd $d
        fvm flutter test --dart-define=OS=ios
        cd ..
    fi
done
