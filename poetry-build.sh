#!/bin/bash

set -e

cd "$(dirname "$0")"

STATUS=$(git status --porcelain)

if [ -n "$STATUS" ]; then
    echo "===================================================================="
    echo "=============== ERROR: repository unclean, stopping! ==============="
    echo "===================================================================="
    echo
    git status
    echo
    echo "===================================================================="
    echo "=============== ERROR: repository unclean, stopping! ==============="
    echo "===================================================================="
    exit 1
fi

# clean up old poetry artifacts:
rm -rf dist/
# clean up old maven artifacts:
rm -rf target/
# clean up potential leftovers from previous runs of this script:
rm -rf sjlogging/

# call maven to perform the "string-filtering" which will substitute the version
# placeholder in __init__.py by the (maven-derived) version string:
mvn process-resources

# move the string-filtered source tree to the project root, so poetry will pick
# it up automatically from there (without explicit configuration):
mv target/classes/sjlogging/ .

# let poetry build the wheel (and tar.gz)
poetry build -vv

# remove the string-filtered source tree:
rm -rf sjlogging/
