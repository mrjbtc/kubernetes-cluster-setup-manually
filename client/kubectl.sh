#
# Installing kubectl command line tools for interacting kubernetes-api
# https://github.com/kelseyhightower/kubernetes-the-hard-way/blob/master/docs/02-jumpbox.md
#
#


sudo wget https://dl.k8s.io/v1.31.2/bin/linux/amd64/kubectl
sudo chmod +x kubectl
sudo mv kubectl /usr/local/bin/
sudo kubectl version --client

# TEST after control plane components (etcd, kube-apiserver, kube-controller-manager, and optional cloud-controller-manager) are done 
sudo kubectl get nodes --kubeconfig admin.kubeconfig