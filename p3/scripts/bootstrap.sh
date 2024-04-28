
# install kubectl to interact with kubernetes cluster
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

# copy the installed kubectl file to /usr/local/bin/kubectl
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# get k3D install script and pipe it to bash
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash

# create argocd namespace
kubectl apply -f ../confs/argocd-namespace.yaml

# create argocd namespace
kubectl apply -f ../confs/dev-namespace.yaml

# install argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml