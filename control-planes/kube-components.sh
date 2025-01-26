# https://github.com/kelseyhightower/kubernetes-the-hard-way/blob/master/docs/08-bootstrapping-kubernetes-controllers.md
# Downloading control plane components
# kubectl is not part of the control plane but for testing might as well to add it

sudo mkdir -p /etc/kubernetes/config
sudo mkdir -p /var/lib/kubernetes/

wget -q --show-progress  --https-only --timestamping \
  "https://dl.k8s.io/v1.31.2/bin/linux/amd64/kubectl" \
  "https://dl.k8s.io/v1.31.2/bin/linux/amd64/kube-apiserver" \
  "https://dl.k8s.io/v1.31.2/bin/linux/amd64/kube-controller-manager" \
  "https://dl.k8s.io/v1.31.2/bin/linux/amd64/kube-scheduler"

chmod +x kube-apiserver kube-controller-manager kube-scheduler kubectl

sudo mv kube-apiserver kube-controller-manager kube-scheduler kubectl /usr/local/bin/


