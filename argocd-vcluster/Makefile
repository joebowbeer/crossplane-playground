run:
# 	crossplane render --verbose -r xr.yaml composition.yaml functions.yaml
	crossplane render --verbose -o observed -r xr.yaml composition.yaml functions.yaml

validate:
	crossplane render -o observed -x xr.yaml composition.yaml functions.yaml | \
	crossplane beta validate ../infra/providers/,xrd.yaml -
