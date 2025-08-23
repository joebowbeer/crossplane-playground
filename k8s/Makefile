SHELL := /bin/bash

run:
	crossplane render --verbose -e extra-resources xr.yaml <(kustomize build composition) functions.yaml -r

validate:
	crossplane render -e extra-resources xr.yaml <(kustomize build composition) functions.yaml -x | \
	crossplane beta validate providers/,xrd.yaml -

prepare:
	kubectl wait --for=condition=available --timeout=120s deployment -n crossplane-system crossplane
	kubectl apply -f providers/
	kubectl wait --for=create --timeout=120s pod -n crossplane-system -l pkg.crossplane.io/provider=provider-helm
	kubectl wait --for=condition=ready --timeout=120s pod -n crossplane-system -l pkg.crossplane.io/provider=provider-helm
	kubectl apply -f provider-configs/
	kubectl apply -f functions.yaml
	kubectl apply -f xrd.yaml
	kubectl apply -k composition/

apply:
	kubectl apply -f xr.yaml,xr2.yaml

delete:
	kubectl delete -f xr.yaml,xr2.yaml || true

clean: delete
	kubectl delete -k composition/ || true
	kubectl delete -f xrd.yaml || true
	kubectl delete -f functions.yaml || true
	kubectl delete -f provider-configs/ || true
	kubectl delete -f providers/ || true
	kubectl wait --for=delete --timeout=120s pod -n crossplane-system -l pkg.crossplane.io/provider=provider-helm || true
