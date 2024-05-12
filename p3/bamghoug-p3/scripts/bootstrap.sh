
# install kubectl to interact with kubernetes cluster
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

# copy the installed kubectl file to /usr/local/bin/kubectl
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# get k3D install script and pipe it to bash
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash

# Create cluster
k3d cluster create -p "80:80"

# create argocd namespace
kubectl apply -f confs/namespaces/argocd-namespace.yaml

# create argocd namespace
kubectl apply -f confs/namespaces/dev-namespace.yaml

# install argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# waiting for argocd service to be ready
for i in {0..7..1}; do
	podName=$(kubectl get pods -n argocd -o jsonpath="{.items[$i].metadata.generateName}")
	echo "Waiting for $podName"
	while [ $(kubectl get pods -n argocd -o jsonpath="{.items[$i].status.phase}") != "Running" ];
	do
		sleep 1;
	done
	echo "$podName is Running"
done

# expose argocd service, redirect its stdout to /dev/null & make it work on background
kubectl port-forward svc/argocd-server -n argocd 8080:443 > /dev/null &

# retrieve The initial password for the admin
argocd admin initial-password -n argocd

# 
argocd app create bamghoug-iot-p3 --repo https://github.com/amg-1337bg/bamghoug-IOT-p3 --path bamghoug-iot-p3 --dest-server https://kubernetes.default.svc --dest-namespace dev