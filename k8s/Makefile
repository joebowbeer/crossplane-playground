run:
	crossplane render --verbose -e extra-resources xr.yaml composition.yaml functions.yaml -r

validate:
	crossplane render -e extra-resources xr.yaml composition.yaml functions.yaml -x | \
	crossplane beta validate providers/,xrd.yaml -

deploy:
	kubectl apply -f providers/
	kubectl apply -f provider-configs/
	kubectl apply -f xrd.yaml,composition.yaml,functions.yaml
	kubectl apply -f xr.yaml
# 	kubectl apply -f xr2.yaml

cleanup:
# 	kubectl delete -f xr2.yaml
	kubectl delete -f xr.yaml
	kubectl delete -f xrd.yaml,composition.yaml,functions.yaml
	kubectl delete -f provider-configs/
	kubectl delete -f providers/
