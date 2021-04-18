#!/bin/bash
set -o errexit

echo "::group::Building the Maven package and verifying it"
mvn ${MAVEN_CLI_ARGS} clean verify
echo "::endgroup::"
