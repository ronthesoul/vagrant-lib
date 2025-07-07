# kube-2node

A Vagrant-based project to set up a 2-node Kubernetes cluster using VirtualBox.

## 🧰 What it Does

This project automatically:
- Installs Git, VirtualBox, and Vagrant (if missing)
- Clones the Vagrant-based Kubernetes environment
- Supports both Linux (bash) and Windows (PowerShell)
- Provisions a Kubernetes master and N worker nodes (default: 1)

## 📦 Prerequisites

- Windows or Linux machine with internet access
- Admin/root privileges
- No need to pre-install VirtualBox or Vagrant — setup scripts handle it

## 💻 Quick Start

Download and run the setup script for your system:

### On Linux

```bash
wget https://raw.githubusercontent.com/ronthesoul/vagrant-lib/master/kube-2node-setup.sh
chmod +x kube-2node-setup.sh
./kube-2node-setup.sh
```

### On Windows (PowerShell)

```powershell
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/ronthesoul/vagrant-lib/master/kube-2node-setup.ps1" -OutFile "kube-2node-setup.ps1"
.\kube-2node-setup.ps1
```

These scripts will:
- Install Git, VirtualBox, and Vagrant (if missing)
- Clone the repo
- Navigate to kube-2node directory

### 🔧 NODE Argument

Both scripts accept a single numeric argument that sets the number of Kubernetes worker nodes to deploy. If omitted, it defaults to 2.

For example:

- `2` = creates `kube-master`, `kube-node-1`, and `kube-node-2`
- `3` = creates `kube-master`, `kube-node-1`, `kube-node-2`, `kube-node-3`

This helps you scale the lab based on your system's capacity.

# Node worker declation
```bash
export NODE_COUNT=2 #For bash
```
```powershell
$env:NODE_COUNT = 2 #For powershell 
```
> This allows you to scale the cluster based on your system's capacity.

### 🚀 Start the Cluster

After running the script, navigate into the cloned project and run:

```bash
cd vagrant-lib/kube-2node
vagrant up
```

This starts the VMs and provisions the cluster.

### 🧪 Reset or Debug

If anything breaks or you want a clean reset:

```bash
vagrant destroy -f
vagrant up
```

To access the machines for debugging:

```bash
 vagrant ssh $Vm -- -t "sudo -i"
```

## 📁 Project Structure

```
vagrant-lib/
├── kube-2node/
│   ├── Vagrantfile
│   ├── provision.sh
│   ├── join.sh
│   ├── post-master-provision.sh
│   ├── post-node-provision.sh
│   └── .gitignore
├── kube-2node-setup.sh
├── kube-2node-setup.ps1
└── README.md
```

## 👤 Author

Written by Ron Negrov