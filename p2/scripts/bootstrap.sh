sudo apt-get update

# install k3s
curl -sfL https://get.k3s.io | sh - 

kubectl apply -f /vagrant/confs/app1.yaml
kubectl apply -f /vagrant/confs/app2.yaml
kubectl apply -f /vagrant/confs/app3.yaml

kubectl apply -f /vagrant/confs/ingress.yaml
