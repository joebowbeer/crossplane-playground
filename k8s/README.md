# Make targets

## In default (or crossplane-cli) devcontainer

In one terminal run

```bash
uv run function-pythonic --insecure --debug
```

In another terminal run

```bash
make
```

```bash
make validate
```

## In kind devcontainer

```bash
make prepare
make apply
crossplane beta trace vcluster vc1
crossplane beta trace vcluster vc2
vcluster list
```

In another terminal run

```bash
argocd admin dashboard --core -n argocd
```

To cleanup

```bash
make clean
```

# Python Notes

```bash
uv lock --upgrade
uv sync
```
