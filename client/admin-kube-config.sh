# https://github.com/kelseyhightower/kubernetes-the-hard-way/blob/master/docs/10-configuring-kubectl.md#configuring-kubectl-for-remote-access
# can also be done in any remote machine e.g local
# admin.kubeconfig
# Update KUBERNETES_ADDRESS 
KUBERNETES_ADDRESS="172.31.19.218"

{
  kubectl config set-cluster kubernetes-the-hard-way \
    --certificate-authority=ca.crt \
    --embed-certs=true \
    --server=https://${KUBERNETES_ADDRESS}:6443 \
    --kubeconfig=admin.kubeconfig

  kubectl config set-credentials admin \
    --client-certificate=admin.crt \
    --client-key=admin.key \
    --embed-certs=true \
    --kubeconfig=admin.kubeconfig

  kubectl config set-context default \
    --cluster=kubernetes-the-hard-way \
    --user=admin \
    --kubeconfig=admin.kubeconfig

  kubectl config use-context default \
    --kubeconfig=admin.kubeconfig
}