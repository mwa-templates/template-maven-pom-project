#!/bin/bash

echo ">>> Executing 'mvn clean deploy' ..."
mvn ${MVN_CLI_ARGS} clean deploy
echo ">>> Done."
