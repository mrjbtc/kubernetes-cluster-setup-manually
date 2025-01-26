# load balance the kubernetes api that resides in two control planes


sudo apt-get install -y nginx
sudo systemctl enable nginx
sudo mkdir -p /etc/nginx/tcpconf.d

# Add this 
# include /etc/nginx/tcpconf.d/*;
# in /etc/nginx/nginx.conf

CONTROL_PLANE_1_PRIVATE_IP="172.31.23.17"
CONTROL_PLANE_2_PRIVATE_IP="172.31.34.20"

cat << EOF | sudo tee /etc/nginx/tcpconf.d/kubernetes.conf
stream {
    upstream kubernetes {
        server ${CONTROL_PLANE_1_PRIVATE_IP}:6443;
        server ${CONTROL_PLANE_2_PRIVATE_IP}:6443;
    }

    server {
        listen 6443;
        listen 443;
        proxy_pass kubernetes;
    }
}
EOF

sudo nginx -s reload

curl -k https://localhost:6443/version