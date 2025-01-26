# https://github.com/kelseyhightower/kubernetes-the-hard-way/blob/master/docs/07-bootstrapping-etcd.md

################### Download ETCD ###########################
sudo wget -q --show-progress --https-only --timestamping \
 "https://github.com/etcd-io/etcd/releases/download/v3.4.34/etcd-v3.4.34-linux-amd64.tar.gz"
 


sudo tar -xvf etcd-v3.4.34-linux-amd64.tar.gz
sudo mv etcd-v3.4.34-linux-amd64/etcd* /usr/local/bin/
sudo mkdir -p /etc/etcd /var/lib/etcd
sudo chmod 700 /var/lib/etcd
sudo cp ca.crt ca.key kube-api-server.key kube-api-server.crt /etc/etcd/


############### systemd units for etcd ###############

# Update the env variables below
# Private IP and hostname of the current control plane instance
PRIVATE_IP="172.31.34.20"
ETCD_NAME="ip-172-31-34-20.eu-west-1.compute.internal"

###########################################################

CONTROL_PLANE_1_HOST_NAME="ip-172-31-23-17.eu-west-1.compute.internal"
CONTROL_PLANE_1_PRIVATE_IP="172.31.23.17"

CONTROL_PLANE_2_HOST_NAME="ip-172-31-34-20.eu-west-1.compute.internal"
CONTROL_PLANE_2_PRIVATE_IP="172.31.34.20"

# Host names and private ips of all control planes instances
CONTROL_PALNES_HOST_AND_PRIVATE_IPS="${CONTROL_PLANE_1_HOST_NAME}=http://${CONTROL_PLANE_1_PRIVATE_IP}:2380,${CONTROL_PLANE_2_HOST_NAME}=http://${CONTROL_PLANE_2_PRIVATE_IP}:2380"


cat << EOF | sudo tee /etc/systemd/system/etcd.service
[Unit]
Description=etcd
Documentation=https://github.com/coreos

[Service]
ExecStart=/usr/local/bin/etcd \\
  --name ${ETCD_NAME} \\
  --initial-advertise-peer-urls http://${PRIVATE_IP}:2380 \\
  --listen-peer-urls http://${PRIVATE_IP}:2380 \\
  --listen-client-urls http://${PRIVATE_IP}:2379,http://127.0.0.1:2379 \\
  --advertise-client-urls http://${PRIVATE_IP}:2379 \\
  --initial-cluster-token etcd-cluster-0 \\
  --initial-cluster ${CONTROL_PALNES_HOST_AND_PRIVATE_IPS} \\
  --initial-cluster-state new \\
  --data-dir=/var/lib/etcd
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF

