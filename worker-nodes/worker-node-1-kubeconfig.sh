# Update env variables
KUBERNETES_ADDRESS="172.31.19.218"
NODE_1="ip-172-31-18-120.eu-west-1.compute.internal"

{
  kubectl config set-cluster kubernetes-the-hard-way \
    --certificate-authority=ca.crt \
    --embed-certs=true \
    --server=https://${KUBERNETES_ADDRESS}:6443 \
    --kubeconfig=${NODE_1}.kubeconfig

  kubectl config set-credentials system:node:${NODE_1} \
    --client-certificate=${NODE_1}.crt \
    --client-key=${NODE_1}.key \
    --embed-certs=true \
    --kubeconfig=${NODE_1}.kubeconfig

  kubectl config set-context default \
    --cluster=kubernetes-the-hard-way \
    --user=system:node:${NODE_1} \
    --kubeconfig=${NODE_1}.kubeconfig

  kubectl config use-context default \
    --kubeconfig=${NODE_1}.kubeconfig
}

# kube-proxy.kubeconfig

{
  kubectl config set-cluster kubernetes-the-hard-way \
    --certificate-authority=ca.crt \
    --embed-certs=true \
    --server=https://${KUBERNETES_ADDRESS}:6443 \
    --kubeconfig=kube-proxy.kubeconfig

  kubectl config set-credentials system:kube-proxy \
    --client-certificate=kube-proxy.crt \
    --client-key=kube-proxy.key \
    --embed-certs=true \
    --kubeconfig=kube-proxy.kubeconfig

  kubectl config set-context default \
    --cluster=kubernetes-the-hard-way \
    --user=system:kube-proxy \
    --kubeconfig=kube-proxy.kubeconfig

  kubectl config use-context default \
    --kubeconfig=kube-proxy.kubeconfig
}


sudo cp kube-proxy.kubeconfig /var/lib/kube-proxy/kubeconfig
sudo cp ${NODE_1}.kubeconfig /var/lib/kubelet/kubeconfig
