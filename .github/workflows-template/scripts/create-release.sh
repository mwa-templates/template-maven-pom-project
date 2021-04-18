#!/bin/bash
set -o errexit

source .github/workflows/scripts/check-maven-distribution-settings.sh

echo "::group::Creating the release and distributing it"
mvn ${MAVEN_CLI_ARGS} build-helper:parse-version release:prepare release:perform \
	-Darguments="${MAVEN_CLI_ARGS} ${MAVEN_RELEASE_ARGS}" \
	-Dgoals="deploy" \
	-DtagNameFormat="${TAG_NAME_FORMAT}" \
	-DdevelopmentVersion="${NEXT_DEVELOPMENT_VERSION}" \
	-DscmCommentPrefix="${GIT_COMMIT_MESSAGE_PREFIX}"
echo "::endgroup::"
