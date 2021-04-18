#!/bin/bash
set -o errexit

source .github/workflows/scripts/check-maven-distribution-settings.sh

echo "::group::Building the Maven package and distributing it"
mvn ${MAVEN_CLI_ARGS} clean deploy
echo "::endgroup::"
