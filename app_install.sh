curl –sfL \
https://rancher-mirror.rancher.cn/k3s/k3s-install.sh | \
INSTALL_K3S_MIRROR=cn sh -s - \
--system-default-registry "registry.cn-hangzhou.aliyuncs.com"
cat >> /etc/rancher/k3s/registries.yaml <<EOF
mirrors:
"docker.io":
endpoint:
- "https://docker.mirrors.ustc.edu.cn" # 可根据需求替换 mirror 站点
- "https://registry-1.docker.io"
EOF
systemctl restart k3s
kubectl apply -f local-path
kubectl apply -f cert-manager
kubectl apply -f  ob-deploy
# 安装helm

kubectl apply -f namespace.yaml
kubectl apply -f secret.yaml -noceanbase
kubectl apply -f configserver.yaml -noceanbase
kubectl apply -f obcluster.yaml -noceanbase

kubectl apply -f grafana.yaml -noceanbase
kubectl apply -f obproxy.yaml -noceanbase
kubectl apply -f oceanbase-todo.yaml -noceanbase
kubectl apply -f prometheus.yaml -noceanbase
kubectl apply -f tenant.yaml -noceanbase


