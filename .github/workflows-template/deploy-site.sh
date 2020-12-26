#!/bin/bash

cd target/checkout
mvn ${MVN_CLI_ARGS} --settings "${MAVEN_SETTINGS_FILE}" site site:stage scm-publish:publish-scm \
		-Dscmpublish.scm.branch="gh-pages" \
		-Dusername="${GITHUB_ACTOR}" \
		-Dpassword="${GITHUB_TOKEN}"
