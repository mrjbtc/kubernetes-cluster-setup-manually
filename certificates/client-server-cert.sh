# https://github.com/kelseyhightower/kubernetes-the-hard-way/blob/master/docs/04-certificate-authority.md#create-client-and-server-certificates

# Need to change worker_node_1 and worker_node_2 variables
worker_node_1="ip-172-31-18-120.eu-west-1.compute.internal"
worker_node_2="ip-172-31-37-192.eu-west-1.compute.internal"

certs=(
  "admin" ${worker_node_1} ${worker_node_2}
  "kube-proxy" "kube-scheduler"
  "kube-controller-manager"
  "kube-api-server"
  "service-accounts"
)

for i in ${certs[*]}; do
  sudo openssl genrsa -out "${i}.key" 4096

  sudo openssl req -new -key "${i}.key" -sha256 \
    -config "ca.conf" -section ${i} \
    -out "${i}.csr"
  
  sudo openssl x509 -req -days 3653 -in "${i}.csr" \
    -copy_extensions copyall \
    -sha256 -CA "ca.crt" \
    -CAkey "ca.key" \
    -CAcreateserial \
    -out "${i}.crt"
done
