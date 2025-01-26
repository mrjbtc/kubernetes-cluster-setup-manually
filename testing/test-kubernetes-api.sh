########################################################

curl -k --cacert ca.crt https://server.kubernetes.local:6443/version
#{
#  "major": "1",
#  "minor": "31",
#  "gitVersion": "v1.31.2",
#  "gitCommit": "5864a4677267e6adeae276ad85882a8714d69d9d",
#  "gitTreeState": "clean",
#  "buildDate": "2024-10-22T20:28:14Z",
#  "goVersion": "go1.22.8",
#  "compiler": "gc",
#  "platform": "linux/amd64"
#}


# OR

curl -k --cacert ca.crt https://localhost:6443/version
#{
#  "major": "1",
#  "minor": "31",
#  "gitVersion": "v1.31.2",
#  "gitCommit": "5864a4677267e6adeae276ad85882a8714d69d9d",
#  "gitTreeState": "clean",
#  "buildDate": "2024-10-22T20:28:14Z",
#  "goVersion": "go1.22.8",
#  "compiler": "gc",
#  "platform": "linux/amd64"
#}

# OR
curl -k --cacert ca.crt https://172.31.23.17:6443/version


# Test kubectl componentstatuses

kubectl get componentstatuses --kubeconfig admin.kubeconfig 
# Warning: v1 ComponentStatus is deprecated in v1.19+
# NAME                 STATUS    MESSAGE   ERROR
# scheduler            Healthy   ok        
# etcd-0               Healthy   ok        
# controller-manager   Healthy   ok

kubectl get nodes --kubeconfig admin.kubeconfig 
# NAME                                          STATUS   ROLES    AGE   VERSION
# ip-172-31-18-120.eu-west-1.compute.internal   Ready    <none>   21m   v1.31.2
# ip-172-31-37-192.eu-west-1.compute.internal   Ready    <none>   12s   v1.31.2       


kubectl get svc --kubeconfig admin.kubeconfig 
# NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
# kubernetes   ClusterIP   10.32.0.1    <none>        443/TCP   47m

kubectl get namespace --kubeconfig admin.kubeconfig 
# NAME              STATUS   AGE
# default           Active   98m
# kube-node-lease   Active   98m
# kube-public       Active   98m
# kube-system       Active   98m