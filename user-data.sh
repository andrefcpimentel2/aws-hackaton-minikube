echo "Adding requirement apt repository..."
sudo apt-get update -y -q
sudo apt-get upgrade -y -q
sudo apt-get install curl apt-transport-https -y -q
echo "Adding virtualbox apt ..."
sudo apt install docker -y -q
sudo usermod -aG docker $USER && newgrp docker

echo "Install Minikube..."
wget https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
chmod +x minikube-linux-amd64
sudo mv minikube-linux-amd64 /usr/local/bin/minikube
sudo chmod 755 /usr/local/bin/minikube

echo "Install kubectl..."
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

echo "Minikube Start..."
minikube config set driver docker
minikube start

echo "Hashicups Start..."
git clone https://github.com/andrefcpimentel2/aws-hackaton-minikube.git
cd aws-hackaton-minikube/modules/
kubectl apply -f hashicups