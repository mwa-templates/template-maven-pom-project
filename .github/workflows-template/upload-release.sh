#!/bin/bash

cd target/checkout
mvn ${MVN_CLI_ARGS} --settings "${MAVEN_SETTINGS_FILE}" verify source:jar javadoc:jar deploy:deploy \
		-DskipTests \
		-DaltDeploymentRepository="${MAVEN_SERVER_ID}::${UPLOAD_URL}"
