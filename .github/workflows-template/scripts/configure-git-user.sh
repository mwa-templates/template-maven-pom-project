#!/bin/bash

echo "::group::Configuring user in global git configuration"
git config --global user.name "GitHub Actions (${GITHUB_ACTOR})" || exit 1
git config --global user.email "actions@users.noreply.github.com" || exit 1
echo "::endgroup::"
