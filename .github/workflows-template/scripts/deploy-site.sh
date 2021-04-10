#!/bin/bash

echo "::group::Generating the site documentation and deploying it"
mvn -B -U site site:stage scm-publish:publish-scm \
	-Dmaven.site.deploy.skip="true" \
	-Dscmpublish.scm.branch="gh-pages" \
	-Dusername="${GITHUB_ACTOR}" \
	-Dpassword="${GITHUB_TOKEN}"
if [ $? -ne 0 ]; then exit 1; fi
echo "::endgroup::"