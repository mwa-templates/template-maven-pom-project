#!/bin/bash

source .github/workflows/scripts/check-maven-distribution-settings.sh

echo "::group::Building the Maven package and distributing it"
mvn -B -U clean deploy || exit 1
echo "::endgroup::"
