#!/bin/bash
set -e

log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

log "Updating system and installing prerequisites..."
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install -y git python3 python3-pip sshpass curl

log "Installing Ansible..."
sudo pip3 install ansible

log "Cloning Kubespray repository..."
if [ ! -d "kubespray" ]; then
    git clone https://github.com/kubernetes-sigs/kubespray.git
fi

cd kubespray

log "Installing Kubespray dependencies..."
sudo pip3 install -r requirements.txt

log "Setting up inventory for a single-node cluster..."
cp -rfp inventory/sample inventory/mycluster

MY_IP=$(hostname -I | awk '{print $1}')
echo "Using IP: $MY_IP"

cat > inventory/mycluster/hosts.ini <<EOF
[all]
$MY_IP ansible_user=$USER

[kube_control_plane]
$MY_IP

[kube_node]
$MY_IP

[etcd]
$MY_IP

[k8s_cluster:children]
kube_control_plane
kube_node
EOF

log "Running Kubespray playbook to set up Kubernetes..."
ansible-playbook -i inventory/mycluster/hosts.ini --become --become-user=root cluster.yml

cd ..

log "Installing Helm..."
if ! command -v helm >/dev/null 2>&1; then
    curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
fi

log "Deploying WordPress Helm Chart..."
helm upgrade --install wordpress-release helm-chart/wordpress-chart --namespace default
log "Bootstrap completed."
echo "Access WordPress at: https://candidate-name.maxtld.dev/wordpress"
echo "Access PhpMyAdmin at: https://candidate-name.maxtld.dev/dbadmin"

