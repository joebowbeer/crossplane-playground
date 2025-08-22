SHELL := /bin/bash

run:
	crossplane render --verbose -e extra-resources xr.yaml <(kustomize build composition) functions.yaml -r

validate:
	crossplane render -e extra-resources xr.yaml <(kustomize build composition) functions.yaml -x | \
	crossplane beta validate providers/,xrd.yaml -
