
# https://github.com/kelseyhightower/kubernetes-the-hard-way/blob/master/docs/09-bootstrapping-kubernetes-workers.md#configure-the-kubelet

# check the actual hostname in your instance and subnet CIDR in your VPC 
NODE_1="ip-172-31-18-120.eu-west-1.compute.internal"
SUBNET="172.31.16.0/20"

sudo cp ca.crt ${NODE_1}.crt ${NODE_1}.key /var/lib/kubelet/

sudo hostnamectl set-hostname ${NODE_1}

cat << EOF | sudo tee /var/lib/kubelet/kubelet-config.yaml
kind: KubeletConfiguration
apiVersion: kubelet.config.k8s.io/v1beta1
authentication:
  anonymous:
    enabled: false
  webhook:
    enabled: true
  x509:
    clientCAFile: "/var/lib/kubelet/ca.crt"
authorization:
  mode: Webhook
clusterDomain: "cluster.local"
clusterDNS:
  - "10.32.0.10"
runtimeRequestTimeout: "15m"
tlsCertFile: "/var/lib/kubelet/${NODE_1}.crt"
tlsPrivateKeyFile: "/var/lib/kubelet/${NODE_1}.key"
EOF


# Create the kubelet unit file:
cat << EOF | sudo tee /etc/systemd/system/kubelet.service
[Unit]
Description=Kubernetes Kubelet
Documentation=https://github.com/kubernetes/kubernetes
After=containerd.service
Requires=containerd.service

[Service]
ExecStart=/usr/local/bin/kubelet \\
  --config=/var/lib/kubelet/kubelet-config.yaml \\
  --kubeconfig=/var/lib/kubelet/kubeconfig \\
  --register-node=true \\
  --v=2
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF

