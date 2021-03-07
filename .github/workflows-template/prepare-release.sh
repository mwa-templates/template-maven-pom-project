#!/bin/bash

echo ">>> Creating release branch ..."
mvn ${MVN_CLI_ARGS} build-helper:parse-version scm:branch \
		-Dbranch="release/\${parsedVersion.majorVersion}.\${parsedVersion.minorVersion}"
echo ">>> Done."

echo ">>> Incrementing development version in the develop branch ..."
mvn ${MVN_CLI_ARGS} build-helper:parse-version versions:set versions:commit \
		-DnewVersion="\${parsedVersion.majorVersion}.\${parsedVersion.nextMinorVersion}-SNAPSHOT"
git commit --all --message="Starting next development iteration ..."
git push
echo ">>> Done."
