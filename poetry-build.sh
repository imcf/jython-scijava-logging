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

### clean up old poetry artifacts:
rm -rf dist/
### clean up potential leftovers from previous runs of this script:
rm -rf sjlogging/

# move the source tree to the project root, so poetry will pick it up
# automatically from there (without explicit configuration):
mv src/main/resources/sjlogging .

### parse the version from 'pom.xml':
PACKAGE_VERSION=$(xmlstarlet sel --template -m _:project -v _:version pom.xml)

### make sure to have a valid Python package version:
case $PACKAGE_VERSION in
*-SNAPSHOT*)
    echo "POM version [$PACKAGE_VERSION] is a snapshot!"
    PACKAGE_VERSION=${PACKAGE_VERSION/-SNAPSHOT/}
    ### calculate the distance to the last release tag:
    LAST_TAG=$(git tag --list 'jython-scijava-logging-*' | sort | tail -n1)
    # echo "Last git tag: '$LAST_TAG'"
    COMMITS_SINCE=$(git rev-list "${LAST_TAG}..HEAD" | wc -l)
    # echo "Nr of commits since last tag: $COMMITS_SINCE"
    HEAD_ID=$(git rev-parse --short HEAD)
    # echo "HEAD commit hash: $HEAD_ID"
    PACKAGE_VERSION="${PACKAGE_VERSION}.dev${COMMITS_SINCE}+${HEAD_ID}"
    ;;
esac

echo "Using package version: [$PACKAGE_VERSION]"

### put the version into the project file and the package source:
sed -i "s/\${project.version}/${PACKAGE_VERSION}/" pyproject.toml
sed -i "s/\${project.version}/${PACKAGE_VERSION}/" sjlogging/__init__.py

### let poetry build wheel and tar.gz:
poetry build -vv

### clean up the moved source tree and restore the previous state:
rm -rf sjlogging/
git restore pyproject.toml
git restore src/main/resources/sjlogging/
