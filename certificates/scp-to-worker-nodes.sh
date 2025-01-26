# https://github.com/kelseyhightower/kubernetes-the-hard-way/blob/master/docs/04-certificate-authority.md#distribute-the-client-and-server-certificates
# copy necessary certs and keys to worker nodes

# Need to change worker_node_1 and worker_node_2 variables
# Update <user>@<host>
worker_node_1="ip-172-31-18-120.eu-west-1.compute.internal"
worker_node_2="ip-172-31-37-192.eu-west-1.compute.internal"
scp ca.crt ${worker_node_1}.crt ${worker_node_1}.key kube-proxy.key kube-proxy.crt ubuntu@worker-node-1:~/
scp ca.crt ${worker_node_2}.crt ${worker_node_2}.key kube-proxy.key kube-proxy.crt ubuntu@worker-node-2:~/
