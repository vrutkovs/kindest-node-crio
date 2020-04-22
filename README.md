# kindest-node-crio
Custom kind config and node image to work with cri-o

Tested on CentOS 8 w/ podman 1.9. Make sure cgroupsv1 is used, as runc/k8s requires that for now.

1. Build the image
```
[root@localhost ~]# podman build -t localhost/vrutkovs/kindest-node-crio:v1.17.2 .
...
```

2. Build `kind` from the master
```
[root@localhost ~]# GO111MODULE="on" go get sigs.k8s.io/kind@master
...
```

3. Start a new cluster
```
[root@localhost ~]# export PATH=$PATH:/root/go/bin/
[root@localhost ~]# export KIND_EXPERIMENTAL_PROVIDER=podman
[root@localhost ~]# kind create cluster --config=2workers.yaml 
using podman due to KIND_EXPERIMENTAL_PROVIDER
enabling experimental podman provider
Creating cluster "kind" ...
 ✓ Ensuring node image (localhost/vrutkovs/kindest-node-crio:v1.17.2) 🖼
 ✓ Preparing nodes 📦 📦 📦  
 ✓ Writing configuration 📜 
 ✓ Starting control-plane 🕹️ 
 ✓ Installing CNI 🔌 
 ✓ Installing StorageClass 💾 
 ✓ Joining worker nodes 🚜 
Set kubectl context to "kind-kind"
You can now use your cluster with:

kubectl cluster-info --context kind-kind

Have a nice day! 👋
[root@localhost ~]# kubectl --context kind-kind get nodes -o wide
NAME                 STATUS   ROLES    AGE     VERSION   INTERNAL-IP   EXTERNAL-IP   OS-IMAGE       KERNEL-VERSION                CONTAINER-RUNTIME
kind-control-plane   Ready    master   6m39s   v1.17.2   10.88.0.15    <none>        Ubuntu 19.10   4.18.0-147.8.1.el8_1.x86_64   cri-o://1.17.3
kind-worker          Ready    <none>   5m56s   v1.17.2   10.88.0.14    <none>        Ubuntu 19.10   4.18.0-147.8.1.el8_1.x86_64   cri-o://1.17.3
kind-worker2         Ready    <none>   5m56s   v1.17.2   10.88.0.13    <none>        Ubuntu 19.10   4.18.0-147.8.1.el8_1.x86_64   cri-o://1.17.3
```
