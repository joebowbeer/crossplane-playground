#!/bin/bash

echo "[START] Install dev tools"

sudo apt update

# sudo apt install -y nano curl zip unzip git zsh bat httpie

# npm install --global @restatedev/restate@latest

kind delete cluster --name crossplane-playground
kind create cluster --name crossplane-playground

# helm repo add headlamp https://kubernetes-sigs.github.io/headlamp/
# helm upgrade --install headlamp headlamp/headlamp --namespace kube-system

export ARGOCD_VERSION=v3.2.1

# arkade install argocd does not provide argocd core option
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/$ARGOCD_VERSION/manifests/core-install.yaml

# Installed by arkade-get feature
# curl -sSL -o argocd https://github.com/argoproj/argo-cd/releases/download/$ARGOCD_VERSION/argocd-linux-amd64
# chmod +x argocd
# sudo mv argocd /usr/local/bin/

# kubectl config set-context --current --namespace=argocd
# argocd login --core
# argocd admin dashboard -n argocd

# arkade install crossplane
# TODO: https://github.com/alexellis/arkade/issues/1239
helm upgrade --install crossplane -n crossplane-system --create-namespace \
  https://charts.crossplane.io/stable/crossplane-2.1.3.tgz

echo "[END] Install dev tools"
