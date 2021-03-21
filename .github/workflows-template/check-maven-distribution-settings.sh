#!/bin/bash

echo ">>> Checking Maven distribution settings ..."
[[ -n "${INPUT_OVERRIDEUSECUSTOMMAVENDISTRIBUTION}" ]] && USE_CUSTOM_MAVEN_DISTRIBUTION=${INPUT_OVERRIDEUSECUSTOMMAVENDISTRIBUTION}
if [[ "${USE_CUSTOM_MAVEN_DISTRIBUTION}" == "true" ]]
then
	if [[ -z "${MAVEN_DISTRIBUTION_SNAPSHOTS_URL}" ]] || [[ -z "${MAVEN_DISTRIBUTION_RELEASES_URL}" ]] || [[ -z "${MAVEN_DISTRIBUTION_USERNAME}" ]] || [[ -z "${MAVEN_DISTRIBUTION_PASSWORD}" ]]
	then
		echo -e "\e[31mCustom distribution management is enabled but not set up correctly.\e[0m"
		echo "The following variables must all be set:"
		echo "    MAVEN_DISTRIBUTION_SNAPSHOTS_URL"
		echo "    MAVEN_DISTRIBUTION_RELEASES_URL"
		echo "    MAVEN_DISTRIBUTION_USERNAME"
		echo "    MAVEN_DISTRIBUTION_PASSWORD"
		exit 1
	else
		echo "Using custom repository for Maven distribution."
	fi
else
	echo "Using GitHub Packages for Maven distribution."
fi
echo ">>> Done."
