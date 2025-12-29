# A configuration file for kubespray vagrant file.
## enable different apps with correct config (metallb)

# After vagrant up (provision):

## ssh to the first host (control node) of the cluster
vagrant ssh k8s-1

## enable the kubectl configuration
sudo chmod 777 /etc/kubernetes/admin.conf

mkdir .kube

cd .kube/

cp /etc/kubernetes/admin.conf config

## copy the config file to your host machine, so you can connect the k8s cluster from your local machine.

vagrant scp  k8s-1:~/.kube/config ~/.kube/config

update the config file with the correct k8s one of the control node ip - 192.168.8.101

## Get admin user token: - to access the dashboard
kubectl apply -f admin-user.yml
kubectl apply -f rolebinding.yml
kubectl -n kube-system create token admin-user

