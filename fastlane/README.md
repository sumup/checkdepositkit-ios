fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

### sumup_ci_setup

```sh
[bundle exec] fastlane sumup_ci_setup
```

Set up CI

### sumup_swiftlint

```sh
[bundle exec] fastlane sumup_swiftlint
```

Lint project into ci-build-out/swiftlint.result

Parameters:

- reporter: Choose output reporter. Available: xcode, json, csv, checkstyle, codeclimate, junit, html, emoji, sonarqube, markdown, github-actions-logging. Default: junit

- disable_failure: Boolean indicating if the lane should fail if linting has errors.

- config_file: The path to the config file. Defaults to #{HelperDefaults.instance.default_swiftlint_config}

- output_file: Path to output SwiftLint result. Defaults to `#{HelperDefaults.instance.default_artifact_dir}/swiftlint.result`

### sumup_build

```sh
[bundle exec] fastlane sumup_build
```

Build a project with necessary setup

Parameters:

- workspace: Path to the workspace file.

- project: Path to the project file.

- scheme: The name of the scheme to run the tests on.

### sumup_test_run

```sh
[bundle exec] fastlane sumup_test_run
```

Run unit tests and do the necessary cleanups afterwards

Parameters:

- workspace: Path to the workspace file.

- project: Path to the project file.

- scheme: The name of the scheme to run the tests on.

- code_coverage: Should code coverage be generated? Defaults to false.

- clean: Should the project be cleaned before building it? Defaults to true.

- force_x86_64_build: Should we make sure to build for x86_64? Defaults to false

- result_bundle: Should an Xcode result bundle be generated in the output directory? Defaults to false

- device: Specify a simulator device. Defaults to iPhone 8

- device_os_version: Specify a simulator version. Defaults to 14.2

- output_files: Specify the test output file

### sumup_lint_pod

```sh
[bundle exec] fastlane sumup_lint_pod
```

Lint the pod

Parameters:

- pod : The name of the podspec to use. Defaults to the value of the `PodHelperDefaults.instance.podspec` variable.

- quick : Indicates if only quick linting should be done without building. Defaults to true.

### sumup_test_pod

```sh
[bundle exec] fastlane sumup_test_pod
```

Run pod tests

Parameters:

- pod : The name of the pod to use. Defaults to the value of the `PodHelperDefaults.instance.podspec` variable.

### sumup_publish_pod

```sh
[bundle exec] fastlane sumup_publish_pod
```

Publish the Pod to our private repo

Parameters:

- pod : The name of the pod to use. Defaults to the value of the `PodHelperDefaults.instance.podspec` variable.

- repo : The name of the sumup repository in your local configuration. Defaults to `sumup-private`

### sumup_bump_pod_version

```sh
[bundle exec] fastlane sumup_bump_pod_version
```

Bump and commit the version number of the Pod. If no exact version is provided, it will bump the podspec automatically.

Parameters:

- pod : The name of the pod to use. Defaults to the value of the `PodHelperDefaults.instance.podspec` variable.

- bump_type: The type of this version bump. Available: patch, minor, major. Default: patch

- version_number: Change to a specific version. This will replace the bump type value. E.g. "1.2.3"

- create_branch: Bool indicating whether to create a new branch for the version update or not. Default: false

- tag_commit: Bool indicating whether to tag the commit or not. Default: false

- push_commit: Bool indicating whether to push the commit (and the tag) or not. Default: false

### sumup_slack_publish_version_result

```sh
[bundle exec] fastlane sumup_slack_publish_version_result
```

Send Slack message with the publish result.

Parameters:

- podspec: The name of the podspec without extension. Required.

- success: Bool indicating the status of the publish. Required.

### sumup_distribute_preview_app

```sh
[bundle exec] fastlane sumup_distribute_preview_app
```

Upload preview app to AppCenter.

Requires:

- the `appcenter` plugin to be installed: `bundle exec fastlane add_plugin appcenter`

- `APP_CENTER_TOKEN` environment variable to be set

- `MATCH_GIT_BASIC_AUTHORIZATION` environment variable to be set

- `MATCH_PASSWORD` environment variable to be set

Parameters:

- scheme: Name of the scheme that builds the preview app. Required.

- bundle_id: Bundle id of the application. Required.

- pod_name: Name of the pod. Defaults to `PodHelperDefaults.instance.podspec`.

- app_center_name: Name of the app in AppCenter. Defaults to `scheme`.

- project_target: Name of the target that builds the preview app. Defaults to `scheme`.

- project_path: Path to the directory containing the project. Defaults to `.`.

- workspace_path: Path to the workspace relative to `project_path`. Defaults to `scheme`.xcworkspace.

- xcodeproj_path: Path to the xcodeproj relative to `project_path`. Defaults to `scheme`.xcodeproj.

- plist_path: Path to the plist relative to `project_path`. Defaults to `scheme`/Info.plist.

- certificates_repo: URL to the match certificates repo. Defaults to `PodHelperDefaults.instance.certificates_repo`

- changelog: Changelog to use for release. Defaults to commit history since last tag.

----


## iOS

### ios test_sample_app

```sh
[bundle exec] fastlane ios test_sample_app
```

Run unit tests of the sample app

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
