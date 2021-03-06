#!/bin/bash

echo ">>> Executing 'mvn clean verify' ..."
mvn ${MVN_CLI_ARGS} clean verify
echo ">>> Done."
