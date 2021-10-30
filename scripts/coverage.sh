#!/usr/bin/env bash

# remember some failed commands and report on exit
set +x
error=false

show_help() {
    printf "usage: $0 [--help] [--report] [<path to package>]
Tool for running all unit and widget tests with code coverage.
(run from root of repo)
where:
    <path to package>
        run tests for package at path only
        (otherwise runs all tests)
    --report
        run a coverage report
        (requires lcov installed)
    --help
        print this message
requires code_coverage package
(install with 'dart pub global activate coverage')
"
    exit 1
}

# run unit and widget tests
runTests () {
  cd $1 ;

  if [ -f "pubspec.yaml" ] && [ -d "test" ]; then
    echo "Check if test $1 - in folder $2 - handles - $3"
    # Moved horizon_blocs to goldens, since Mac's are more powerful.
    if [[ -z $3 ]] || 
      ( [[ $3 == "golden" ]] && ( [[ $1 == "./packages/horizon_ui_kit" ]] || [[ $1 == "./packages/horizon_test_data" ]] || [[ $1 == "." ]] ) ) || 
      ( [[ $3 == "non-golden" ]] && [[ $1 != "./packages/horizon_ui_kit" ]] && [[ $1 != "./packages/horizon_test_data" ]] && [[ $1 != "." ]] ); then      
      echo "Running tests in $1"
      escapedPath="$(echo $1 | sed 's/\//\\\//g')"
      # run tests with coverage
      if grep flutter pubspec.yaml > /dev/null; then
        fvm flutter test --dart-define=OS=ios --coverage --machine > machine.log || error=true
        fvm flutter pub get && fvm flutter pub run dart_dot_reporter:dart_dot_reporter ./machine.log
        if [ -d "coverage" ]; then
          # combine line coverage info from package tests to a common file
          sed "s/^SF:lib/SF:$escapedPath\/lib/g" coverage/lcov.info >> $2/lcov.info
          rm -rf "coverage"
        fi
      else
        # Pure dart is currently not supported due to requirements for running an isolate in the background and then extract and convert coverage reports.
        echo "WARNING: running coverage tooling without flutter is currently not supported. Please add dependency to flutter_test dependency to pubspec and try again."
      fi
    fi
  fi
  cd - > /dev/null
}

runReport() {
    if [ -f "lcov.info" ] && ! [ "$TRAVIS" ]; then
        genhtml lcov.info -o coverage --no-function-coverage -s -p `pwd`
        open coverage/index.html
    fi
}

if ! [ -d .git ]; then printf "\nError: not in root of repo"; show_help; fi

case $1 in
    --help)
        show_help
        ;;
    --report)
        if ! [ -z ${2+x} ]; then
            printf "\nError: no extra parameters required: $2"
            show_help
        fi
        runReport
        ;;
    --golden)
        currentDir=`pwd`
        rm -f lcov.info
        dirs=(`find . -maxdepth 2 -type d`)
        for dir in "${dirs[@]}"; do
            runTests $dir $currentDir golden
        done
        ;;
    --non_golden)
        currentDir=`pwd`
        rm -f lcov.info
        dirs=(`find . -maxdepth 2 -type d`)
        for dir in "${dirs[@]}"; do
            runTests $dir $currentDir 'non-golden'
        done
        ;;
      *)
        currentDir=`pwd`
        # if no parameter passed
        if [ -z $1 ]; then
            rm -f lcov.info
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
        ;;
esac

# Fail the build if there was an error
if [ "$error" = true ] ;
then
    exit -1
fi
