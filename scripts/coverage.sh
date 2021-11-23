#!/bin/sh

CURRENT_DIR=$(dirname "$0")
PACKAGES_DIR="packages"
TEST_DIR="test"
FVM=''

runAllTests() {
    cd "$CURRENT_DIR/.."
    echo "Testing lib"
    $FVM flutter test --coverage --machine > machine.log || error=true
    $FVM flutter pub get && $FVM flutter pub run dart_dot_reporter:dart_dot_reporter ./machine.log

    cd $PACKAGES_DIR
    for d in $(ls); do
        if [ -d "$d/$TEST_DIR" ]; then
            echo "Testing $d package"
            cd $d
            rm -f coverage/lcov.info
            $FVM flutter test --coverage --machine > machine.log || error=true
            $FVM flutter pub get && $FVM flutter pub run dart_dot_reporter:dart_dot_reporter ./machine.log
            if [ -d "coverage" ]; then
                # combine line coverage info from package tests to a common file
                escapedPath="$(echo ./packages/$d | sed 's/\//\\\//g')"
                sed "s/^SF:lib/SF:$escapedPath\/lib/g" coverage/lcov.info >> ../../coverage/lcov.info
                # remove package coverage folder
                rm -rf "coverage"
            fi
            cd .. # packages
        fi
    done
    cd .. # root

    # install remove_from_coverage if needed
    $FVM flutter pub global activate remove_from_coverage
    # remove .g.dart files from lcov.info
    $FVM flutter pub global run remove_from_coverage:remove_from_coverage -f coverage/lcov.info -r '\.g\.dart$'
    # remove generated folder from lcov.info
    $FVM flutter pub global run remove_from_coverage:remove_from_coverage -f coverage/lcov.info -r '\bgenerated\b'
}

case $1 in
    --useFvm)
        FVM='fvm'
        runAllTests
        ;;
    *)
        runAllTests
        ;;
esac