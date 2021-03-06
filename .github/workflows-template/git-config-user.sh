#!/bin/bash

echo ">>> Configuring user in global git configuration ..."
git config --global user.name "GitHub Actions (${GITHUB_ACTOR})"
git config --global user.email "actions@users.noreply.github.com"
echo ">>> Done."
