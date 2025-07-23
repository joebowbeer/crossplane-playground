run:
	crossplane render --verbose xr.yaml composition.yaml functions.yaml -r

validate:
	crossplane render xr.yaml composition.yaml functions.yaml -x | \
	crossplane beta validate ../infra/providers/,xrd.yaml -
