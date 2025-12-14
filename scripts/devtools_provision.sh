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

# TODO: arkade can install argocd core? 
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/$ARGOCD_VERSION/manifests/core-install.yaml

# TODO: arkade get argocd
curl -sSL -o argocd https://github.com/argoproj/argo-cd/releases/download/$ARGOCD_VERSION/argocd-linux-amd64
chmod +x argocd
sudo mv argocd /usr/local/bin/

# kubectl config set-context --current --namespace=argocd
# argocd login --core
# argocd admin dashboard -n argocd

# TODO: arkade install crossplane
helm upgrade --install crossplane -n crossplane-system --create-namespace \
  https://charts.crossplane.io/stable/crossplane-2.0.2.tgz

echo "[END] Install dev tools"
