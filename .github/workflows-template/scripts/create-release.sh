#!/bin/bash

source .github/workflows/scripts/check-maven-distribution-settings.sh

echo "::group::Creating the release and distributing it"
mvn -B -U build-helper:parse-version release:prepare release:perform \
	-Darguments="-B -U ${MAVEN_RELEASE_ARGS}" \
	-Dgoals="deploy" \
	-DtagNameFormat="${TAG_NAME_FORMAT}" \
	-DdevelopmentVersion="${NEXT_DEVELOPMENT_VERSION}" \
	-DscmCommentPrefix="${GIT_COMMIT_MESSAGE_PREFIX}"
if [ $? -ne 0 ]; then exit 1; fi
echo "::endgroup::"
