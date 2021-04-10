#!/bin/bash

echo "::group::Saving release version"
cd target/checkout || exit 1
RELEASE_VERSION=$(mvn help:evaluate -Dexpression=project.version -q -DforceStdout) || exit 1
echo "Release version: ${RELEASE_VERSION}"
echo "::set-output name=releaseVersion::${RELEASE_VERSION}"
echo "::endgroup::"
