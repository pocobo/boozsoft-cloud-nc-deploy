#git config --global url."https://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@github.com".insteadOf "https://github.com"
#git clone https://github.com/pocobo/boozsoft-cloud-nc-deploy.git
mkdir /root/.kube

# 1.安装k3s
curl –sfL \
https://rancher-mirror.rancher.cn/k3s/k3s-install.sh | \
INSTALL_K3S_MIRROR=cn sh -s - \
--system-default-registry "registry.cn-hangzhou.aliyuncs.com"
cp -rf /etc/rancher/k3s/k3s.yaml /root/.kube/config
cat << 'EOF' > /etc/rancher/k3s/registries.yaml
mirrors:
  bj.env.caishuida.cn:
    endpoint:
      - "http://bj.env.caishuida.cn:88"
  "123.112.240.231:88":
    endpoint:
      - "http://123.112.240.231:88"
  "docker.io":
    endpoint:
      - "https://ddkwemz5.mirror.aliyuncs.com"
      - "https://docker.1panel.live"
      - "https://hub.rat.dev/"
      - "https://docker.chenby.cn"
      - "https://docker.m.daocloud.io"
  "crpi-hrvq5w8tkla6visb.cn-beijing.personal.cr.aliyuncs.com":
    endpoint:
      - "https://crpi-hrvq5w8tkla6visb.cn-beijing.personal.cr.aliyuncs.com"

configs:
  "harbor.boozsoft.fun:8443":
    auth:
      username: admin
      password: Harbor12345
  "192.168.199.60":
    auth:
      username: admin
      password: Harbor12345
  "crpi-hrvq5w8tkla6visb.cn-beijing.personal.cr.aliyuncs.com":
    auth:
      username: pocobo@1099662296022792
      password: sigoo123
EOF
systemctl restart k3s

# 安装helm
snap install helm --classic

# 安装k8s前置资源
kubectl apply -f base_yaml/cert-manager.yaml
kubectl apply -f base_yaml/local-path-storage.yaml
kubectl apply -f base_yaml/operator_namespace.yaml
kubectl apply -f base_yaml/csd_namespace.yaml
until kubectl get pods -ncert-manager | grep "cert-manager" | awk '{if ($3 != "Running") exit 1}'; do
    echo "Waiting for cert-manager pods to be ready..."
    kubectl get pods -ncert-manager
    sleep 5
done
until kubectl get endpoints oceanbase-webhook-service -n oceanbase-system; do
    echo "Waiting for oceanbase-webhook-service endpoints..."
    sleep 5
done

echo "oceanbase-webhook-service endpoints are ready!"

echo "All cert-manager pods are running! Proceeding to next step..."
kubectl apply -f base_yaml/operator.yaml


# 安装oceanbase


# 获取 eth0 IP 地址
ETH0_IP=$(ip addr show eth0 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1)

# 使用获取的 IP 创建 ConfigMap
kubectl create configmap db-config \
  --from-literal=DB_HOST=$ETH0_IP \
  --from-literal=DB_USER=root@metatenant#metadb \
  --from-literal=DB_PORT=30883 \
  --from-literal=DB_NAME=oceanbase \
  --from-literal=SYS_USER=root -ncsd

kubectl create secret generic db-secret \
  --from-literal=PASSWORD=rootpass \
  --from-literal=SYS_PASSWORD=rootpass -ncsd

kubectl apply -f ob-deploy/namespace.yaml
kubectl apply -f ob-deploy/secret.yaml -noceanbase
kubectl apply -f ob-deploy/configserver.yaml -noceanbase
kubectl apply -f ob-deploy/obcluster.yaml -noceanbase
kubectl apply -f ob-deploy/grafana.yaml -noceanbase
kubectl apply -f ob-deploy/obproxy.yaml -noceanbase
kubectl wait --for=condition=Ready configmap db-config -n csd --timeout=60s

kubectl apply -f ob-deploy/prometheus.yaml -noceanbase
kubectl apply -f ob-deploy/tenant.yaml -noceanbase
# 导入数据库
kubectl apply -f init_job.yaml -ncsd
kubectl apply -f ob-deploy/oceanbase-todo.yaml -noceanbase
kubectl apply -f ssls/dz.api.caishuida.com.yaml -ncsd
kubectl apply -f ssls/dz.caishuida.com.yaml -ncsd
kubectl apply -f ssls/secret-origindz.caishuida.com.yaml -ncsd
# 安装中间件
helm install server-middle  ./server-middle -ncsd
helm install csdapp  ./dz-server -ncsd
