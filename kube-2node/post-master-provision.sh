#!/bin/bash
set -e

curl -sSLo cronfig_init.sh https://raw.githubusercontent.com/ronthesoul/Cronfig/main/cronfig_init.sh && chmod +x cronfig_init.sh && ./cronfig_init.sh 2
curl -s https://raw.githubusercontent.com/ahmetb/kubectl-aliases/master/.kubectl_aliases >> $HOME/.alias_bashrc
source ~/.bashrc

sudo git clone https://github.com/ahmetb/kubectx /opt/kubectx
sudo ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx
sudo ln -s /opt/kubectx/kubens /usr/local/bin/kubens

API_IP="192.168.56.10"


sudo rm -rf /etc/kubernetes /var/lib/etcd /var/lib/kubelet

sudo kubeadm init \
  --pod-network-cidr=10.244.0.0/16 \
  --apiserver-advertise-address=$API_IP \
  --cri-socket=unix:///run/containerd/containerd.sock

export KUBECONFIG=/etc/kubernetes/admin.conf

mkdir -p /home/vagrant/.kube
cp /etc/kubernetes/admin.conf /home/vagrant/.kube/config
chown vagrant:vagrant /home/vagrant/.kube/config

until curl -sk https://$API_IP:6443/readyz | grep -q "ok"; do
  echo "Waiting for kube-apiserver to be ready..."
  sleep 5
done

until sudo -u vagrant kubectl get nodes &>/dev/null; do
  echo "Waiting for node to show up..."
  sleep 5
done

sudo -u vagrant kubectl apply -f https://raw.githubusercontent.com/flannel-io/flannel/master/Documentation/kube-flannel.yml
rm -rf /vagrant/join.sh
kubeadm token create --print-join-command > /vagrant/join.sh
chmod +x /vagrant/join.sh
