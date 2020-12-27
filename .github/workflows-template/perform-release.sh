#!/bin/bash

mvn ${MVN_CLI_ARGS} build-helper:parse-version release:prepare release:perform \
		-Darguments="${MVN_CLI_ARGS} -Dreleasing" \
		-Dgoals="deploy" \
		-DtagNameFormat="v@{project.version}" \
		-DdevelopmentVersion="\${parsedVersion.majorVersion}.\${parsedVersion.minorVersion}.\${parsedVersion.nextIncrementalVersion}-SNAPSHOT" \
        -DscmCommentPrefix="[skip ci] " \
        -Dusername="${GITHUB_ACTOR}"\
        -Dpassword="${GITHUB_TOKEN}"
