
# install kubectl to interact with kubernetes cluster
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

# copy the installed kubectl file to /usr/local/bin/kubectl
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# get k3D install script and pipe it to bash
sudo curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash

# install argocd CLI
curl -sSL -o argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
sudo install -m 555 argocd-linux-amd64 /usr/local/bin/argocd
rm argocd-linux-amd64

# Create cluster
sudo k3d cluster create -p "80:80"

# create argocd namespace
sudo kubectl apply -f confs/namespaces/argocd-namespace.yaml

# create argocd namespace
sudo kubectl apply -f confs/namespaces/dev-namespace.yaml

# install argocd
sudo kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# waiting for argocd service to be ready
sleep 5;
for i in 0 1 2 3 4 5 6
do
	podName=$(sudo kubectl get pods -n argocd -o jsonpath="{.items[$i].metadata.generateName}")
	echo "\033[0;33mWaiting for $podName\033[0m"
	while [ $(sudo kubectl get pods -n argocd -o jsonpath="{.items[$i].status.phase}") != "Running" ];
	do
		sleep 1;
	done
	echo "\033[0;32m$podName is Running\033[0m"
done

# expose argocd service, redirect its stdout to /dev/null & make it work on background
sudo kubectl port-forward svc/argocd-server -n argocd 8080:443 > /dev/null &

# retrieve The initial password for the admin
sudo argocd admin initial-password -n argocd

# 
sudo argocd app create bamghoug-iot-p3 --repo https://github.com/amg-1337bg/bamghoug-IOT-p3 --path bamghoug-iot-p3 --dest-server https://kubernetes.default.svc --dest-namespace dev