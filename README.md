# Template Maven POM Project

This is a template repository for my Maven JAR projects, but of course it might also be useful for others. The main part of this template are the workflow files that define how to build, verify, and deploy the Maven project, as well as how to release it.

This readme file describes the underlying concept and the first necessary steps after creating a new repository based on this template repository.

## Branching model

The workflow files assume a branching model that is somewhat inspired by the [git-flow branching model](https://nvie.com/posts/a-successful-git-branching-model/), but much less complicated.

The `main` branch is the default branch, as GitHub now proposes for all new repositories. It should always contain a potentially deployable or releasable version of the software. Each actual development should take place in another branch (i.e. `feature/...` or `bugfix/...`). Finished work should then simply be merged into the `main` branch, usually via a pull request. For releasing, a branch named `release/...` must be used. This can be done by the corresponding workflow files (see below).

## Versioning concept

Some of the workflow files (see below) depend on a correct versioning in the POM of the project. In the `main` branch this version should always have a major and a minor version, but no patch version; i.e. `1.0-SNAPSHOT`.

## Workflow concepts

The workflow file `build-and-verify.yaml` simply runs a `mvn verify` command after a push to a branch that is not `main` or `release/*`.

The workflow file `build-and-deploy.yaml` simply runs a `mvn deploy` command after a push to the `main` branch or to any `release/*` branch. The artifacts are deployed to GitHub Packages.

The workflow file `prepare-release.yaml` can only be triggered manually for the `main` branch, and it does two steps. First, it creates a new branch `release/x.y`, based on the current POM's snapshot version number (`x.y-SNAPSHOT`). Second, it increments the minor version in the POM, so it ends up with `x.(y++)-SNAPSHOT` in the `main` branch.

The workflow file `perform-release.yaml` can only be triggered manually for a `release/...` branch, and it does three steps. First, it uses the [Maven release plugin](https://maven.apache.org/maven-release/maven-release-plugin/) to actually do the release (incl. tagging). This also increments the patch version in the POM, so it ends up with `x.y.(z++)-SNAPSHOT` in the current `release/...` branch. Second, it can additionally upload the release to Bintray. This step can be enabled or disabled (default: enabled). Third, it can create and deploy site documentation to GitHub Pages. This step can also be enabled or disabled (default: disabled).

## First steps

After creating a new repository based on this template, you need to do some initializing steps.

### Setup in GitHub

Besides doing some basic settings (like "Wikis", "Projects", "Issues", "Merge buttons", etc.), you need to add the following repository secret:

	PERSONAL_ACCESS_TOKEN_GITHUB

This personal access token must have the full repo scope and the full packages scope.

### Upload to Bintray

The release upload to Bintray is enabled by default in the `perform-release.yaml` workflow. If you do not need that, you should consider setting the default value of the action input `doUploadToBintray` to `false`.

Otherwise, you also must add the following repository secrets:

	BINTRAY_USERNAME
	BINTRAY_API_KEY

Additionally, you have to create the following Bintray package:

	<REPO_OWNER> -> maven-repo -> <REPO_NAME>

The `<REPO_OWNER>` must be the same name of the user or the organization under which your GitHub repository is hosted. The `<REPO_NAME>` is the name of the newly created GitHub repository.

### Site deployment

The generation and deployment of site documentation is disabled by default in the `perform-release.yaml` workflow. If you feel to need that, you should consider setting the default value of the action input `doDeploySite` to `true`.

If enabled, you also need to enable the `gh-pages` branch for the newly created repository, because this is where the generated site will be deployed to. Note, that this only works for public repositories.

### Source code adjustments

The POM file contains the following placeholders that must be replaced with their actual values:

	$PROJECT_GROUP_ID$
	$PROJECT_ARTIFACT_ID$
	$PROJECT_VERSION$
	$PROJECT_NAME$
	$PROJECT_DESCRIPTION$
	$REPO_OWNER$
	$REPO_NAME$

Also important: Rename the directory `.github/workflows-template` to `.github/workflows`.

Additionally, you can/should do the following steps:

- The POM contains some out-commented sections. You should add the needed information or consider removing those sections.
- Because the file `README.md` (this file) is also copied, you should consider to delete the whole file or at least its content.
- Check whether the `LICENSE` fits your needs or should be replaced with a more appropriate one.

Now commit and push your changes. You are ready to go ...
