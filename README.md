# Authgear Helm chart

# Minimal supported k8s version

1.21

## Release a new version

1. Update version in [Chart.yaml](./authgear/Chart.yaml) and commit as "Bump version to X.Y.Z".
1. Push the commit to the `release` branch.
1. Add github personal access token to [.cr.yaml](./.cr.yaml).
    - Create personal access token in Github with `repo` scope.
    - Set it in environment variable `CR_TOKEN`.
1. Run `make upload-release` from the "Bump version to X.Y.Z" commit. The commit must already exist on GitHub (pushed via the branch above). This tags that commit as the release.
1. Run `make update-index`.
1. Update [CHANGELOG.md](./CHANGELOG.md) with changes for the new version:
   - Add a new section with the version number, date, and a link to the commit range (e.g., `[abc1234..def5678](https://github.com/authgear/helm-charts/compare/abc1234..def5678)`)
   - Use "Added", "Fixed", "Security", or "Breaking Changes" subsections as appropriate
   - Reference the [Keep a Changelog](https://keepachangelog.com/) format
1. Commit the changelog as "Release X.Y.Z" and push to the `release` branch.
1. Merge the `release` branch into main.
