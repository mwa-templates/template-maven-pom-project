#!/bin/bash
set -o errexit

if [ -z "${OUTPUT_VARIABLE_NAME}" ]; then OUTPUT_VARIABLE_NAME=projectVersion; fi

echo "::group::Extracting project version (into variable '${OUTPUT_VARIABLE_NAME}')"
if [ -n "${PROJECT_DIRECTORY}" ]
then
	cd ${PROJECT_DIRECTORY}
fi
MAVEN_EXTRACT_COMMAND="mvn help:evaluate -Dexpression=project.version -q"
${MAVEN_EXTRACT_COMMAND}
PROJECT_VERSION=$(${MAVEN_EXTRACT_COMMAND} -DforceStdout)
echo "Project version: ${PROJECT_VERSION}"
echo "::endgroup::"

echo "::set-output name=${OUTPUT_VARIABLE_NAME}::${PROJECT_VERSION}"
