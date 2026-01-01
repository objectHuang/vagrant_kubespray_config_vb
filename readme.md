# Kubernetes Cluster Setup with Vagrant & Kubespray

A production-ready Kubernetes cluster configuration using Vagrant and Kubespray with pre-configured services including MetalLB, Nginx Ingress, Dashboard, and Helm.

## 📋 Cluster Configuration

- **Nodes**: 3 instances (1 control plane + 2 workers)
- **OS**: Ubuntu 22.04
- **Resources per VM**: 4 CPUs, 16GB RAM
- **Network**: 192.168.8.0/24 subnet
- **Enabled Services**:
  - Kubernetes Dashboard
  - Helm package manager
  - Metrics Server (monitoring)
  - MetalLB (load balancing)
  - Nginx Ingress Controller
  - Local Path Provisioner (storage)
  - Docker Registry
  - IPVS proxy mode

## 🚀 Getting Started

### Step 1: Start the Cluster
```bash
vagrant up
```
This will provision a 3-node Kubernetes cluster with all services enabled.

### Step 2: Configure kubectl Locally

1. **Connect to the control plane node**:
   ```bash
   vagrant ssh k8s-1
   ```

2. **Prepare the kubeconfig file on the VM**:
   ```bash
   sudo chmod 777 /etc/kubernetes/admin.conf
   mkdir -p ~/.kube
   cp /etc/kubernetes/admin.conf ~/.kube/config
   ```

3. **Copy the configuration to your host machine**:
   ```bash
   vagrant scp k8s-1:~/.kube/config ~/.kube/config
   ```

4. **Update the kubeconfig with the correct control plane IP**:
   ```bash
   # Edit ~/.kube/config and replace the server IP with 192.168.8.101
   sed -i 's/127.0.0.1:6443/192.168.8.101:6443/g' ~/.kube/config
   ```

### Step 3: Verify Your Connection
```bash
kubectl cluster-info
kubectl get nodes
```

## 📊 Access Kubernetes Dashboard

1. **Create the admin user**:
   ```bash
   kubectl apply -f admin-user.yml
   kubectl apply -f rolebinding.yml
   ```

2. **Generate the admin token**:
   ```bash
   kubectl -n kube-system create token admin-user
   ```

3. **Access the dashboard**:
   ```bash
   kubectl proxy
   ```
   Then navigate to: `http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/`

4. **Use the token from Step 2** to log in.

## 🔧 Network Details

- **Control Plane Node**: k8s-1 (192.168.8.101)
- **Worker Nodes**: k8s-2 (192.168.8.102), k8s-3 (192.168.8.103)
- **MetalLB IP Range**: 192.168.8.200 - 192.168.8.240

## 📝 File Descriptions

- **config.rb**: Vagrant configuration with VM specs and Kubespray variables
- **admin-user.yml**: ServiceAccount for dashboard access
- **rolebinding.yml**: ClusterRoleBinding for admin user privileges

## 🛑 Cleanup

To destroy the cluster:
```bash
vagrant destroy -f
```

