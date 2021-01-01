#!/bin/bash

mvn ${MVN_CLI_ARGS} build-helper:parse-version scm:branch \
		-Dbranch="release/\${parsedVersion.majorVersion}.\${parsedVersion.minorVersion}"

mvn ${MVN_CLI_ARGS} build-helper:parse-version versions:set versions:commit \
		-DnewVersion="\${parsedVersion.majorVersion}.\${parsedVersion.nextMinorVersion}-SNAPSHOT"
git commit --all --message="prepare for next development iteration"
git push
