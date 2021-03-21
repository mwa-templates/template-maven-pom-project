#!/bin/bash

[[ -n "${OVERRIDE_DO_SITE_DEPLOYMENT}" ]] && DO_SITE_DEPLOYMENT=${OVERRIDE_DO_SITE_DEPLOYMENT}
if [[ "${DO_SITE_DEPLOYMENT}" == "true" ]]
then
	echo ">>> Generating site documentation and deploying it ..."
	cd target/checkout
	mvn ${MVN_CLI_ARGS} site site:stage scm-publish:publish-scm \
			-Dmaven.site.deploy.skip="true" \
			-Dscmpublish.scm.branch="gh-pages" \
			-Dusername="${GITHUB_ACTOR}" \
			-Dpassword="${GITHUB_TOKEN}"
	echo ">>> Done."
else
	echo ">>> Site generation and deployment is disabled."
fi
