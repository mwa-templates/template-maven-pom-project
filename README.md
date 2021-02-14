# Template for a simple Maven project

This is a template repository for my Maven projects (but also might be useful for others). The main part of this template are the workflow files that define how to build, verify, and deploy the Maven project, as well as how to create a release version.

This readme file describes the underlying concepts and the first necessary steps after creating a new repository based on this template repository.

## Branching model

The workflow files assume a branching model that is somewhat inspired by the [git-flow branching model](https://nvie.com/posts/a-successful-git-branching-model/), but much less complicated.

The `main` branch is the default branch, as GitHub now proposes for all new repositories. It should always contain a potentially deployable or releasable version of the software. Each actual development should take place in another branch (i.e. `feature/...` or `bugfix/...`). Finished work should then simply be merged into the `main` branch, usually via a pull request. For releasing, a branch named `release/...` must be used. This can be done by the corresponding workflow files (see below).

## Versioning concept

Some of the workflow files (see below) depend on a correct versioning in the POM of the project. In the `main` branch this version should always have a major and a minor version, but no patch version; i.e. `1.0-SNAPSHOT`. The same holds true for any feature or bugfix development branch. For the release branches, the below mentioned wokflows will take care of the versioning.

## Workflow concepts

The workflow file `build-and-deploy.yaml` simply runs a `mvn deploy` command after a push to the `main` branch or to any `release/*` branch. The generated snapshot artifacts are deployed to GitHub Packages.

The workflow file `build-and-verify.yaml` simply runs a `mvn verify` command after a push to any other branch, i.e. for `feature/...` or `bugfix/...`.

The workflow file `prepare-release.yaml` can only be triggered manually for the `main` branch. It first creates a new branch `release/x.y`, based on the POM's current snapshot version number (`x.y-SNAPSHOT`). Then it increments the POM's minor version in the `main` branch, so it ends up with `x.(y++)-SNAPSHOT`.

The workflow file `perform-release.yaml` can only be triggered manually for a `release/...` branch. It first uses the [Maven release plugin](https://maven.apache.org/maven-release/maven-release-plugin/) to actually do the release (incl. tagging). The generated release artifacts are deployed to GitHub Packages. The patch version in the POM is also incremented, so it ends up with `x.y.(z++)-SNAPSHOT` in the current `release/...` branch. Additionally, this workflow can upload the release artifacts to a 3rd party platform (e.g. a self-hosted repository manager), and it also can generate site documentation and deploy it to GitHub Packages. All of these additional steps are disabled by default.

## First steps

After creating a new repository based on this template, you need to do some initializing steps.

### Setup in GitHub

Besides doing some basic settings (like "Wikis", "Projects", "Issues", "Merge buttons", etc.), you need to add the following repository secret:

	PERSONAL_ACCESS_TOKEN_GITHUB

This personal access token must have the full repo scope and the full packages scope.

### Upload to an additional Maven repository

The release upload to an additional Maven repository is disabled by default in the `perform-release.yaml` workflow. If you do need that, you should consider setting the default value of the action input `doUploadToAdditionalRepo` to `true`.

If enabled, you also must add the following secrets in your GitHub repository:

	MAVEN_UPLOAD_URL
	MAVEN_UPLOAD_USERNAME
	MAVEN_UPLOAD_PASSWORD

The upload script is able to detect and replace the following placeholders in the upload URL:

	%%GITHUB_ACTOR%%
	%%GITHUB_REPO_OWNER%%
	%%GITHUB_REPO_NAME%%

See the files `perform-release.yaml` and `upload-release.sh` for more details.

### Site deployment

The generation and deployment of site documentation is disabled by default in the `perform-release.yaml` workflow. If you do need that, you should consider setting the default value of the action input `doDeploySite` to `true`.

If enabled, you also must enable the `gh-pages` branch, because this is where the generated site documentation will be deployed to. Note, that this only works for public GitHub repositories.

### Source code adjustments

The POM file contains the following placeholders that must be replaced with their actual values:

	%%PROJECT_GROUP_ID%%
	%%PROJECT_ARTIFACT_ID%%
	%%PROJECT_VERSION%%
	%%PROJECT_NAME%%
	%%PROJECT_DESCRIPTION%%
	%%REPO_OWNER%%
	%%REPO_NAME%%

Then rename the directory `.github/workflows-template` to `.github/workflows`.

Additionally, you can/should do the following steps:

- The POM contains some out-commented sections. You should add the needed information or consider removing those sections.
- For POM projects the `src` folder might not be needed. Consider to delete it.
- Because this file (`README.md`) is also copied, you should consider to delete this file or at least change its content.
- Check whether the license fits your needs or should be replaced with a more appropriate one. The license is mentioned in two places: in the `LICENSE` file and in the `<licenses>` section in the POM.

Now commit and push your changes. You are ready to go ...
