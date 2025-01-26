#######################################################
# Download and install worker components (kube-proxy, kubelet, containerd) and for some network 
sudo apt-get update
sudo apt-get -y install socat conntrack ipset

swapon --show

swapoff -a

wget -q --show-progress --https-only --timestamping \
  "https://github.com/kubernetes-sigs/cri-tools/releases/download/v1.31.1/crictl-v1.31.1-linux-amd64.tar.gz" \
  "https://storage.googleapis.com/kubernetes-the-hard-way/runsc" \
  "https://github.com/opencontainers/runc/releases/download/v1.2.1/runc.amd64" \
  "https://github.com/containernetworking/plugins/releases/download/v1.6.0/cni-plugins-linux-amd64-v1.6.0.tgz" \
  "https://github.com/containerd/containerd/releases/download/v2.0.0/containerd-2.0.0-linux-amd64.tar.gz" \
  "https://dl.k8s.io/v1.31.2/bin/linux/amd64/kubectl" \
  "https://dl.k8s.io/v1.31.2/bin/linux/amd64/kube-proxy" \
  "https://dl.k8s.io/v1.31.2/bin/linux/amd64/kubelet"


sudo mkdir -p \
  /etc/cni/net.d \
  /opt/cni/bin \
  /var/lib/kubelet \
  /var/lib/kube-proxy \
  /var/lib/kubernetes \
  /var/run/kubernetes \
  containerd


sudo tar -xvf crictl-v1.31.1-linux-amd64.tar.gz
sudo tar -xvf containerd-2.0.0-linux-amd64.tar.gz -C containerd
sudo tar -xvf cni-plugins-linux-amd64-v1.6.0.tgz -C /opt/cni/bin/
sudo mv runc.amd64 runc
sudo chmod +x crictl kubectl kube-proxy kubelet runc 
sudo mv crictl kubectl kube-proxy kubelet runc /usr/local/bin/
sudo mv containerd/bin/* /bin/

