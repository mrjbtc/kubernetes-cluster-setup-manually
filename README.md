## Manual Kubernetes cluster setup for learning purposes.

##### Cluster Architecture Diagram
 ![Architecure Diagram](https://github.com/mrjbtc/kubernetes-cluster-setup-manually/blob/main/k8s_cluster.png)


<h2>Compute Resources</h2>

1. Update `variables.tf` in `compute-resources`.
2. Deploy terraform in `compute-resources`.


<h2>Utilities</h2>

Pick one instace as a jump host to install these `client/utilities.sh` and `client/kubectl.sh`.

<h2>Certificates</h2>

1. `certificates/ca.sh` to generate `ca.crt ca.key` using `opnessl`.
2. And `certificates/client-server-cert.sh` for generating the rest of certificates 
   necessary for other components as well as admin user.
3. Distribute these keys and crts into control planes and worker nodes. 
   `certificates/scp-to-control-planes.sh` and `certificates/scp-to-worker-nodes.sh`.


<h2>Update /etc/hosts</h2>
   
   Update `/etc/hosts` in all instances with `hosts/hosts.txt` and make sure to update the values relative to the correct ips and host names.

<h2>Load balance the two control planes</h2>

To server traffic in both control planes instance.
1. Install `load-balance-control-planes/nginx.sh`.
2. Update `/etc/nginx/nginx.conf` and add `include /etc/nginx/tcpconf.d/*`.
3. `sudo nginx -s reload`

<h2>Control planes</h2>

1. Install and create unit file for etcd. `control-planes/etcd.sh`.
2. Download kube components `control-planes/kube-components.sh`.
3. Generate encryption and `encryption-config.yaml` in `control-planes/encryption.sh`.
4. Generate `kube-controller-manager.kubeconfig` and `kube-scheduler.kubeconfig` 
	in `control-planes/kube-config.sh`.
5. Create unit files for kube-apiserver(`control-planes/kube-apiserver.sh`), 
	kube-controller-manager(`control-planes/kube-controller-manager.sh`), and
	kube-scheduler(`control-planes/kube-scheduler.sh`).
6. Lastly, start services above `etcd`, `kube-apiserver`, `kube-controller-manager`,
	and `kube-scheduler` in `control-planes/start-kube-components.sh`.
7. Make sure all services are up and running.


<h3>Testing k8s API</h3>

1. Generate `admin.kubeconfig` in `client/admin-kube-config.sh`
2. Test something `kubectl get componentstatuses --kubeconfig admin.kubeconfig`. Components should be healthy 
```
NAME                 STATUS    MESSAGE   ERROR
scheduler            Healthy   ok        
etcd-0               Healthy   ok        
controller-manager   Healthy   ok

```

<h2>Worker Nodes</h2>

1. Download worker node components in `worker-nodes/components.sh`.
2. Create `config.toml` and unit file for `containerd` `worker-nodes/containerd.sh`.
3. Create `bridge.conf` and `loopback.conf` `worker-nodes/worker-node-1-network.sh`.
4. Generate kube-config `worker-nodes/worker-node-1-network.sh`.
5. Create unit file for kubelet(`worker-nodes/worker-node-1-kubelet.sh`), 
	and kube-proxy(`worker-nodes/kube-proxy.sh`).
6. Create and apply RBAC for k8s API to access kubelet `worker-nodes/rbac-kubelet-auth.sh`.
7. Start services in worker nodes `worker-nodes/start-worker-components.sh`.

<h3>Testing worker nodes</h3>

```
 kubectl get nodes --kubeconfig admin.kubeconfig 

NAME                                          STATUS     ROLES    AGE   VERSION
ip-172-31-18-120.eu-west-1.compute.internal   NotReady   <none>   20h   v1.31.2
ip-172-31-37-192.eu-west-1.compute.internal   Ready      <none>   19h   v1.31.2

```


