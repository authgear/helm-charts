.PHONY: helm-repo-add
helm-repo-add:
	helm repo add ingress-traefik https://helm.traefik.io/traefik
	helm repo add jetstack https://charts.jetstack.io
	helm repo add bitnami https://charts.bitnami.com/bitnami
	helm repo add rimusz https://charts.rimusz.net

.PHONY: helm-dependency-update
helm-dependency-update:
	helm dependency update authgear

# This makefile was authored against cr version 1.7.0
# https://github.com/helm/chart-releaser/releases/tag/v1.7.0
.PHONY: check-cr-version
check-cr-version:
	command -v cr
	test $$(cr version | grep GitVersion | awk '{ print $$2 }') = 'v1.7.0'

# cr supports --skip-existing to skip previously uploaded packages,
# but it is very slow.
# Therefore, when we run cr upload, we have to make sure --package-path contains
# packages that have not been uploaded before.
.PHONY: upload-release
upload-release: check-cr-version
	rm -rf .deploy
	cr package authgear --package-path .deploy
	cr upload --config ./.cr.yaml --package-path .deploy --skip-existing

# cr has the following conventions
# 1. The remote is named "origin".
# 2. The GitHub Pages branch is named "gh-pages".
# 3. The GitHub Pages branch exists locally.
.PHONY: update-index
update-index: check-cr-version
	git branch -D gh-pages || true
	git fetch origin gh-pages:gh-pages
	cr package authgear
	git remote set-url origin https://github.com/authgear/helm-charts.git
	cr index --config ./.cr.yaml --push
	git remote set-url origin git@github.com:authgear/helm-charts.git
