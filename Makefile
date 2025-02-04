# This makefile was authored against cr version 1.4.0
# https://github.com/helm/chart-releaser/releases/tag/v1.4.0


.PHONY: helm-repo-add
helm-repo-add:
	helm repo add ingress-traefik https://helm.traefik.io/traefik
	helm repo add jetstack https://charts.jetstack.io
	helm repo add bitnami https://charts.bitnami.com/bitnami
	helm repo add rimusz https://charts.rimusz.net

.PHONY: helm-dependency-update
helm-dependency-update:
	helm dependency update authgear

# cr is not smart enough to ignore previously uploaded packages.
# Therefore, when we run cr upload, we have to make sure --package-path contains
# packages that have not been uploaded before.
.PHONY: upload-release
upload-release:
	rm -rf .deploy
	cr package authgear --package-path .deploy
	cr upload --config ./.cr.yaml --package-path .deploy

# Before you run this target, make ensure you have the gh-pages branch locally.
# cr expects the push URL to be https, so this make target will change the url temporarily.
.PHONY: update-index
update-index:
	git fetch --all
	cr package authgear
	git remote set-url origin https://github.com/authgear/helm-charts.git
	cr index --config ./.cr.yaml --push
	git remote set-url origin git@github.com:authgear/helm-charts.git
