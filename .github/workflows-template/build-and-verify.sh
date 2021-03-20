#!/bin/bash

echo ">>> Building project and verifying the package ..."
mvn ${MVN_CLI_ARGS} clean verify
echo ">>> Done."
