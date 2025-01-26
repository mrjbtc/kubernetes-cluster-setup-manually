# update SUBNET where the node/instance is running
SUBNET="172.31.32.0/20"

cat > bridge.conf << EOF
{
  "cniVersion": "1.0.0",
  "name": "bridge",
  "type": "bridge",
  "bridge": "cni0",
  "isGateway": true,
  "ipMasq": true,
  "ipam": {
    "type": "host-local",
    "ranges": [
      [{"subnet": "${SUBNET}"}]
    ],
    "routes": [{"dst": "0.0.0.0/0"}]
  }
}
EOF

cat > loopback.conf << EOF
{
  "cniVersion": "1.1.0",
  "name": "lo",
  "type": "loopback"
}
EOF

sudo cp bridge.conf loopback.conf /etc/cni/net.d/