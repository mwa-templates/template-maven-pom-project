#!/bin/bash

echo ">>> Creating release and distributing the released package ..."
echo "Note that this also tags the release version and increments the development version in the release branch."
[[ -n "${OVERRIDE_USE_CUSTOM_MAVEN_DISTRIBUTION}" ]] && USE_CUSTOM_MAVEN_DISTRIBUTION=${OVERRIDE_USE_CUSTOM_MAVEN_DISTRIBUTION}
if [[ "${USE_CUSTOM_MAVEN_DISTRIBUTION}" != "true" ]]
then
	export MAVEN_DISTRIBUTION_SNAPSHOTS_URL=https://maven.pkg.github.com/${GITHUB_REPOSITORY}
	export MAVEN_DISTRIBUTION_RELEASES_URL=https://maven.pkg.github.com/${GITHUB_REPOSITORY}
	export MAVEN_DISTRIBUTION_USERNAME=${GITHUB_ACTOR}
	export MAVEN_DISTRIBUTION_PASSWORD=${GITHUB_TOKEN}
fi
mvn ${MVN_CLI_ARGS} build-helper:parse-version release:prepare release:perform \
		-Darguments="${MVN_CLI_ARGS} -Dreleasing" \
		-Dgoals="deploy" \
		-DtagNameFormat="v@{project.version}" \
		-DdevelopmentVersion="\${parsedVersion.majorVersion}.\${parsedVersion.minorVersion}.\${parsedVersion.nextIncrementalVersion}-SNAPSHOT" \
        -DscmCommentPrefix="[skip ci] "
echo ">>> Done."
