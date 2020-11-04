# This makefile was authored against cr version 1.1.1

# cr is not smart enough to ignore previously uploaded packages.
# Therefore, when we run cr upload, we have to make sure --package-path contains
# packages that have not been uploaded before.
.PHONY: upload-release
upload-release:
	rm -rf .deploy
	cr package authgear --package-path .deploy
	cr upload --config ./.cr.yaml --package-path .deploy

# Before you run this target, make ensure you have the gh-pages branch locally.
.PHONY: update-index
update-index:
	git fetch --all
	cr package authgear
	cr index --config ./.cr.yaml --push
