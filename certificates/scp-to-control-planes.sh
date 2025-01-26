# copy necessary certs and keys to control planes
# Update <user>@<host>
scp ca.key \
	ca.crt \
	kube-api-server.key \
	kube-api-server.crt \
	service-accounts.key \
	service-accounts.crt \
	kube-controller-manager.key \
	kube-controller-manager.crt \
	kube-scheduler.key \
	kube-scheduler.crt \
	kube-api-server.key \
	kube-api-server.crt \
	ubuntu@control-plane-1:~/

scp ca.key \
	ca.crt \
	kube-api-server.key \
	kube-api-server.crt \
	service-accounts.key \
	service-accounts.crt \
	kube-controller-manager.key \
	kube-controller-manager.crt \
	kube-scheduler.key \
	kube-scheduler.crt \
	kube-api-server.key \
	kube-api-server.crt \
	ubuntu@control-plane-2:~/