#!/bin/sh

CWD=`pwd`
PACKAGES_RELATIVE_PATH="packages"
PACKAGES_DIR="$CWD/$PACKAGES_RELATIVE_PATH"

fvm flutter pub get

for d in $(ls $PACKAGES_DIR); do
    PACKAGE_DIR="$PACKAGES_DIR/$d"
    echo "Entering $PACKAGES_RELATIVE_PATH/$d"
    cd $PACKAGE_DIR && fvm flutter pub get
done

fvm flutter pub run build_runner build --delete-conflicting-outputs