#!/bin/bash

echo ">>> Building project and distributing the built package ..."
[[ -n "${OVERRIDE_USE_CUSTOM_MAVEN_DISTRIBUTION}" ]] && USE_CUSTOM_MAVEN_DISTRIBUTION=${OVERRIDE_USE_CUSTOM_MAVEN_DISTRIBUTION}
if [[ "${USE_CUSTOM_MAVEN_DISTRIBUTION}" != "true" ]]
then
	export MAVEN_DISTRIBUTION_SNAPSHOTS_URL=https://maven.pkg.github.com/${GITHUB_REPOSITORY}
	export MAVEN_DISTRIBUTION_RELEASES_URL=https://maven.pkg.github.com/${GITHUB_REPOSITORY}
	export MAVEN_DISTRIBUTION_USERNAME=${GITHUB_ACTOR}
	export MAVEN_DISTRIBUTION_PASSWORD=${GITHUB_TOKEN}
fi
mvn ${MVN_CLI_ARGS} clean deploy
echo ">>> Done."
