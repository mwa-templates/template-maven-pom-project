#!/bin/bash

echo "::group::Building the Maven package and verifying it"
mvn -B -U clean verify || exit 1
echo "::endgroup::"
