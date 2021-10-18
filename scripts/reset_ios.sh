#!/bin/sh

fvm flutter clean;
rm -Rf ios/Pods;
rm -Rf ios/.symlinks;
rm -Rf ios/Flutter/Flutter.framework;
rm -Rf ios/Flutter/Flutter.podspec;
fvm flutter pub get;
cd ./ios;
pod install;