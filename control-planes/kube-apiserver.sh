##################################################
# Update ENV variables

KUBERNETES_ADDRESS="172.31.19.218"

# Private IP of the current control plane instance
INTERNAL_IP="172.31.34.20"
##################################################


CONTROL_PLANE_1="172.31.23.17"
CONTROL_PLANE_2="172.31.34.20"

cat << EOF | sudo tee /etc/systemd/system/kube-apiserver.service
[Unit]
Description=Kubernetes API Server
Documentation=https://github.com/kubernetes/kubernetes

[Service]
ExecStart=/usr/local/bin/kube-apiserver \
  --advertise-address=${INTERNAL_IP} \\
  --allow-privileged=true \\
  --apiserver-count=1 \\
  --audit-log-maxage=30 \\
  --audit-log-maxbackup=3 \\
  --audit-log-maxsize=100 \\
  --audit-log-path=/var/log/audit.log \\
  --authorization-mode=Node,RBAC \\
  --bind-address=0.0.0.0 \\
  --client-ca-file=/var/lib/kubernetes/ca.crt \
  --enable-admission-plugins=NamespaceLifecycle,NodeRestriction,LimitRanger,ServiceAccount,DefaultStorageClass,ResourceQuota \\
  --etcd-servers=http://$CONTROL_PLANE_1:2379,http://$CONTROL_PLANE_2:2379 \\
  --event-ttl=1h \\
  --encryption-provider-config=/var/lib/kubernetes/encryption-config.yaml \\
  --kubelet-certificate-authority=/var/lib/kubernetes/ca.crt \\
  --kubelet-client-certificate=/var/lib/kubernetes/kube-api-server.crt \\
  --kubelet-client-key=/var/lib/kubernetes/kube-api-server.key \\
  --runtime-config='api/all=true' \\
  --service-account-key-file=/var/lib/kubernetes/service-accounts.crt \\
  --service-account-signing-key-file=/var/lib/kubernetes/service-accounts.key \\
  --service-account-issuer=https://${KUBERNETES_ADDRESS}:6443 \\
  --service-cluster-ip-range=10.32.0.0/24 \\
  --service-node-port-range=30000-32767 \\
  --tls-cert-file=/var/lib/kubernetes/kube-api-server.crt \\
  --tls-private-key-file=/var/lib/kubernetes/kube-api-server.key \\
  --v=2 \\
  --kubelet-preferred-address-types=InternalIP,InternalDNS,Hostname,ExternalIP,ExternalDNS
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF

