run:
	crossplane render --verbose -e extra-resources xr.yaml composition.yaml functions.yaml -r

validate:
	crossplane render -e extra-resources xr.yaml composition.yaml functions.yaml -x | \
	crossplane beta validate ../infra/providers/,xrd.yaml -
