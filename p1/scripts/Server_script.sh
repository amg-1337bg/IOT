
# install k3s
curl -sfL https://get.k3s.io | sh - 

# copy the token file to shared folder
sudo cp /var/lib/rancher/k3s/server/token /vagrant/confs/