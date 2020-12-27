# Placeholders

Throughout this file and in some source files, some placeholders are mentioned:

	$PROJECT_GROUP_ID$
	$PROJECT_ARTIFACT_ID$
	$PROJECT_VERSION$
	$PROJECT_NAME$
	$REPO_OWNER$
	$REPO_NAME$
	$BINTRAY_USERNAME$

These placeholders need to be replaced with their actual values.

# Setup in GitHub

Adjust the settings like "Wikis", "Projects", "Merge button", etc.
If site deployment is needed (or wanted), enable the `gh-pages` branch for the repository (easy way: simply use a starting theme).

Add the following repository secrets:

	PERSONAL_ACCESS_TOKEN_GITHUB
	BINTRAY_API_KEY

The `PERSONAL_ACCESS_TOKEN_GITHUB` must have the full repo scope and the full packages scope.</br>
The `BINTRAY_API_KEY` must belong to the above mentioned `$BINTRAY_USERNAME$`.

# Setup in Bintray

Under `Bintray -> $REPO_OWNER$ -> repositories -> maven-repo`, add a new package with the name `$REPO_NAME$`.


# Source setup

Rename the directory `.github/workflows-template` to `.github/workflows`.
Then replace the above mentioned placeholders in the following files:

	pom.xml
	.github/workflows/perform-release.yaml

There are some out-commented sections in the POM. Add the needed information or remove these sections.<br>

If site deployment is needed (or wanted), consider setting the default value of the action input `skipSiteDeployment` to `false` in the file `.github/workflows/perform-release.yaml`.

Now this "first steps" file can be deleted, before committing and pushing the changes. You are ready to go ...
