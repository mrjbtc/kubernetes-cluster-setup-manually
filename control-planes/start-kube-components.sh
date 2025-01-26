sudo systemctl daemon-reload
sudo systemctl enable etcd kube-apiserver kube-controller-manager kube-scheduler
sudo systemctl start etcd kube-apiserver kube-controller-manager kube-scheduler
sudo systemctl status etcd kube-apiserver kube-controller-manager kube-scheduler


# Test etcd

sudo etcdctl member list

# Sample output to verify 
# 7526dfb609009a62, started, ip-172-31-23-17.eu-west-1.compute.internal, http://172.31.23.17:2380, http://172.31.23.17:2379, false
# d59f25050f94b0fd, started, ip-172-31-34-20.eu-west-1.compute.internal, http://172.31.34.20:2380, http://172.31.34.20:2379, false