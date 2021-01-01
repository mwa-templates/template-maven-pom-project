#!/bin/bash

REPO_OWNER=${GITHUB_REPOSITORY%/*}
REPO_NAME=${GITHUB_REPOSITORY#*/}
UPLOAD_URL=${UPLOAD_URL_TEMPLATE//%%REPO_OWNER%%/$REPO_OWNER}
UPLOAD_URL=${UPLOAD_URL//%%REPO_NAME%%/$REPO_NAME}

cd target/checkout
mvn ${MVN_CLI_ARGS} --settings "${MAVEN_SETTINGS_FILE}" verify source:jar javadoc:jar deploy:deploy \
		-Duploading \
		-DskipTests \
		-DaltDeploymentRepository="${MAVEN_SERVER_ID}::${UPLOAD_URL}"
		