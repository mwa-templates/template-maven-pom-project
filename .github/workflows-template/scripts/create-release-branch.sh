#!/bin/bash

echo "::group::Creating release branch"
mvn -B -U build-helper:parse-version scm:branch -Dbranch="${RELEASE_BRANCH_NAME}" || exit 1
echo "::endgroup::"
