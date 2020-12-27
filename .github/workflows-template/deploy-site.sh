#!/bin/bash

cd target/checkout
mvn ${MVN_CLI_ARGS} site site:stage scm-publish:publish-scm \
		-Dmaven.site.deploy.skip="true" \
		-Dscmpublish.scm.branch="gh-pages" \
		-Dusername="${GITHUB_ACTOR}" \
		-Dpassword="${GITHUB_TOKEN}"
