run:
	crossplane render --verbose xr.yaml composition.yaml functions.yaml -r

validate:
	crossplane render xr.yaml composition.yaml functions.yaml --include-full-xr | \
	crossplane beta validate ../providers/,xrd.yaml -
