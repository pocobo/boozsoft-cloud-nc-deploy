curl –sfL \
https://rancher-mirror.rancher.cn/k3s/k3s-install.sh | \
INSTALL_K3S_MIRROR=cn sh -s - \
--system-default-registry "registry.cn-hangzhou.aliyuncs.com"

cp -rf /etc/rancher/k3s/k3s.yaml /root/.kube/config
cp -rf registries.yaml /etc/rancher/k3s/registries.yaml
systemctl restart k3s

# 安装helm
snap install helm
kubectl apply -f local-path
kubectl apply -f cert-manager
kubectl apply -f  ob-deploy

kubectl apply -f namespace.yaml
kubectl apply -f secret.yaml -noceanbase
kubectl apply -f configserver.yaml -noceanbase
kubectl apply -f obcluster.yaml -noceanbase
kubectl apply -f grafana.yaml -noceanbase
kubectl apply -f obproxy.yaml -noceanbase
kubectl apply -f oceanbase-todo.yaml -noceanbase
kubectl apply -f prometheus.yaml -noceanbase
kubectl apply -f tenant.yaml -noceanbase

# 导入数据库

helm install csdapp install ./dz-server
