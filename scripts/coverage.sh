#!/usr/bin/env bash

# remember some failed commands and report on exit
set +x
error=false
fvm=''

show_help() {
    printf "usage: $0 [--help] [--report] [<path to package>]
Tool for running all unit and widget tests with code coverage.
(run from root of repo)
where:
    <path to package>
        run tests without FVM
    --useFvm
        run tests with FVM
    --help
        print this message
requires code_coverage package
(install with 'dart pub global activate coverage')
"
    exit 1
}

runAllTests() {
    currentDir=`pwd`
    # if no parameter passed
    if [ -z $1 ]; then
        rm -f coverage/lcov.info
        dirs=(`find . -maxdepth 2 -type d`)
        for dir in "${dirs[@]}"; do
            runTests $dir $currentDir
        done
    else
        if [[ -d "$1" ]]; then
            runTests $1 $currentDir
        else
            printf "\nError: not a directory: $1"
            show_help
        fi
    fi
    removeGeneratedFilesFromLcov
}

removeGeneratedFilesFromLcov() {
    dart pub global activate remove_from_coverage
    pub global run remove_from_coverage:remove_from_coverage -f coverage/lcov.info -r '\.g\.dart$'
}

# run unit and widget tests
runTests () {
    cd $1 ;
    if [ -f "pubspec.yaml" ] && [ -d "test" ]; then
        echo "Check if test $1 - in folder $2 - handles - $3"
        # Moved horizon_blocs to goldens, since Mac's are more powerful.
        if [[ -z $3 ]]; then      
            echo "Running tests in $1"
            escapedPath="$(echo $1 | sed 's/\//\\\//g')"
            # run tests with coverage
            if grep flutter pubspec.yaml > /dev/null; then
            $fvm flutter test --coverage --machine > machine.log || error=true
            $fvm flutter pub get && $fvm flutter pub run dart_dot_reporter:dart_dot_reporter ./machine.log
            if [ -d "coverage" ]; then
                # combine line coverage info from package tests to a common file
                sed "s/^SF:lib/SF:$escapedPath\/lib/g" coverage/lcov.info >> $2/coverage/lcov.info
                # rm -rf "coverage"
            fi
            else
            # Pure dart is currently not supported due to requirements for running an isolate in the background and then extract and convert coverage reports.
            echo "WARNING: running coverage tooling without flutter is currently not supported. Please add dependency to flutter_test dependency to pubspec and try again."
            fi
        fi
    fi
    cd - > /dev/null
}

if ! [ -d .git ]; then printf "\nError: not in root of repo"; show_help; fi

case $1 in
    --help)
        show_help
        ;;
    --useFvm)
        fvm='fvm'
        runAllTests
        ;;
    *)
        runAllTests
        ;;
esac

# Fail the build if there was an error
if [ "$error" = true ] ;
then
    exit -1
fi
