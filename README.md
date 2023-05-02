# Authgear Helm chart

# Minimal supported k8s version

1.21

## Release a new version

1. Update version in [Chart.yaml](./authgear/Chart.yaml) and commit.
1. Add github personal access token to [.cr.yaml](./.cr.yaml).
    - Create personal access token in Github with `repo` scope.
    - Add `token: __replace_with_the_token__` to the file.
1. Run `make upload-release`.
1. Run `make update-index`.
1. Commit and push the updated files to the master branch.
