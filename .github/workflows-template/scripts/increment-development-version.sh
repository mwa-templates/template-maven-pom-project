#!/bin/bash

echo "::group::Incrementing development version"
mvn -B -U build-helper:parse-version versions:set versions:commit -DnewVersion="${NEXT_DEVELOPMENT_VERSION}" || exit 1
git commit --all --message="${GIT_COMMIT_MESSAGE}" || exit 1
git push || exit 1
echo "::endgroup::"
