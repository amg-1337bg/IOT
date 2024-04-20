
# curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="agent --server https://192.168.56.110:6443 --token-file /vagrant/confs/token --node-name bamghougSW --with-node-id" sh -s - > /dev/null 2>&1 &

# # stop k3s
# /usr/local/bin/k3s-killall.sh

# # run k3s as agent
# k3s agent --server https://192.168.56.110:6443 --token-file /vagrant/confs/token --node-name bamghougSW --with-node-id 
