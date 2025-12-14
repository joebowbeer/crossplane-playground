from crossplane.pythonic import B64Encode, BaseComposite, Map

class Composite(BaseComposite):

    def compose(self):
        name = self.metadata.name
        namespace = name

        release = self.resources.release('helm.crossplane.io/v1beta1', 'Release', name=name)
        release.spec.forProvider.chart.repository = 'https://charts.loft.sh'
        release.spec.forProvider.chart.name = 'vcluster'
        release.spec.forProvider.chart.version = '0.30.3'
        release.spec.forProvider.namespace = namespace
        release.spec.forProvider.values.controlPlane.proxy.extraSANs[0] = f'{name}.{namespace}'
        release.spec.providerConfigRef.name = 'helm-provider'
        release.spec.rollbackLimit = 1

        secret_name = f'vc-{name}'
        vcluster_secret = self.requireds.vcluster_secret('v1', 'Secret', namespace, secret_name)[0]
        if vcluster_secret:
            argocd_namespace = 'argocd'
            argocd_secret = self.resources.argocd_secret('v1', 'Secret', argocd_namespace, secret_name)
            argocd_secret.metadata.labels['argocd.argoproj.io/secret-type'] = 'cluster'
            argocd_secret.type = 'Opaque'
            argocd_secret.data.name = B64Encode(name)
            argocd_secret.data.server = B64Encode(f'https://{name}.{namespace}:443')
            argocd_secret.data.config = B64Encode(format(self.argcd_secret(vcluster_secret), 'json'))
            argocd_secret.ready = argocd_secret.observed
        else:
            self.ready = False

    def argcd_secret(self, secret):
        config = Map()
        config.tlsClientConfig.insecure = True
        # ArgoCD wants these fields to be B64 encoded, so don't decode them
        config.tlsClientConfig.caData = secret.data['certificate-authority']
        config.tlsClientConfig.certData = secret.data['client-certificate']
        config.tlsClientConfig.keyData = secret.data['client-key']
        return config
