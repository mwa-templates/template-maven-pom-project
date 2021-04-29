#!/bin/bash
set -o errexit

echo "::group::Generating the site documentation and deploying it"
mvn ${MAVEN_CLI_ARGS} site site:stage scm-publish:publish-scm \
	-Dmaven.site.deploy.skip="true" \
	-Dscmpublish.scm.branch="gh-pages" \
	-Dusername="${GITHUB_ACTOR}" \
	-Dpassword="${GITHUB_TOKEN}"
echo "::endgroup::"
