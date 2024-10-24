#git config --global url."https://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@github.com".insteadOf "https://github.com"
#git clone https://github.com/pocobo/boozsoft-cloud-nc-deploy.git
mkdir /root/.kube
mkdir -p  /etc/rancher/k3s/
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

# 安装helm
#snap install helm --classic
wget -c https://github.com/pocobo/boozsoft-cloud-nc-deploy/releases/download/1.0.0/helm-v3.16.2-linux-amd64.tar.gz && tar -zxvf helm-v3.16.2-linux-amd64.tar.gz &&  mv linux-amd64/helm /bin/
# 安装k8s前置资源
kubectl apply -f base_yaml/cert-manager.yaml
kubectl apply -f base_yaml/local-path-storage.yaml
kubectl apply -f base_yaml/operator_namespace.yaml
kubectl apply -f base_yaml/csd_namespace.yaml

echo "Waiting for cert-manager components to be ready..."

# 等待所有 cert-manager pods 变成 Running
until kubectl get pods -n cert-manager | grep "cert-manager" | grep -v "0/1" | awk '{if ($3 != "Running") exit 1}' > /dev/null 2>&1; do
    echo "Waiting for cert-manager pods to be Running..."
    kubectl get pods -n cert-manager
    sleep 5
done

echo "All cert-manager pods are Running, waiting for webhook service..."

# 等待 webhook endpoint 就绪
until kubectl get endpoints cert-manager-webhook -n cert-manager 2>/dev/null | grep -v "NAME" | awk '{if ($2 == "") exit 1}'; do
    echo "Waiting for cert-manager-webhook endpoint..."
    kubectl get endpoints cert-manager-webhook -n cert-manager
    sleep 5
done

echo "Webhook service has endpoints, waiting for API availability..."
echo "创建并等待 webhook 测试..."

# 使用 curlimages/curl 镜像创建测试 pod
echo "等待 ServiceAccount 就绪..."
until kubectl get serviceaccount default -n cert-manager > /dev/null 2>&1; do
   echo "Waiting for ServiceAccount default to be ready..."
   sleep 5
done
kubectl run curl-test --image=curlimages/curl -n cert-manager -- /bin/sh -c '
while true; do
    if curl -sk https://cert-manager-webhook.cert-manager.svc:443/mutate; then
        echo "Webhook is responsive!"
        exit 0
    else
        echo "Waiting for cert-manager webhook to be responsive..."
        sleep 5
    fi
done'

# 等待 pod 完成
echo "等待测试结果..."
while true; do
   if kubectl logs curl-test -n cert-manager 2>/dev/null | grep "Webhook is responsive!" > /dev/null; then
       echo "Webhook 已就绪!"
       sleep 15
       break
   fi
   echo "等待 webhook 就绪..."
   sleep 5
done


# 查看结果
echo "查看测试日志..."
kubectl logs -f curl-test -n cert-manager

# 清理测试 pod
kubectl delete pod curl-test -n cert-manager

# 最后验证 API 是否完全就绪
echo "Verifying cert-manager API..."
until kubectl get --raw /apis/cert-manager.io/v1 >/dev/null 2>&1; do
    echo "Waiting for cert-manager API to be available..."
    sleep 5
done

echo "cert-manager is fully ready! Now you can proceed with other installations."
kubectl apply -f base_yaml/operator.yaml

kubectl apply -f base_yaml/operator2.yaml -noceanbase-system
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
kubectl run curl-test2 --image=curlimages/curl -n oceanbase-system -- /bin/sh -c '
while true; do
    if curl -sk https://oceanbase-webhook-service.oceanbase-system.svc:443/mutate-oceanbase-oceanbase-com-v1alpha1-obcluster; then
        echo "Webhook is responsive!"
        exit 0
    else
        echo "Waiting for cert-manager webhook to be responsive..."
        sleep 5
    fi
done'

# 等待 pod 完成
echo "等待测试结果..."
while true; do
   if kubectl logs curl-test2 -n oceanbase-system 2>/dev/null | grep "Webhook is responsive!" > /dev/null; then
       echo "Webhook 已就绪!"
       sleep 15
       break
   fi
   echo "等待 webhook 就绪..."
   sleep 5
done
kubectl apply -f ob-deploy/obcluster.yaml -noceanbase
kubectl apply -f ob-deploy/grafana.yaml -noceanbase
kubectl apply -f ob-deploy/obproxy.yaml -noceanbase
kubectl wait --for=condition=Ready configmap db-config -n csd --timeout=60s

kubectl apply -f ob-deploy/prometheus.yaml -noceanbase
until kubectl get events -n oceanbase-system | grep "became leader"; do
  echo "Waiting for leader election..."
  sleep 5
done
kubectl apply -f ob-deploy/tenant.yaml -noceanbase
while true; do
   STATUS=$(kubectl get obtenant -n oceanbase -o jsonpath='{.items[0].status.status}' 2>/dev/null)

   if [ "$STATUS" = "running" ]; then
       echo "Tenant is running!"
       kubectl get obtenant -n oceanbase
       break
   elif [ "$STATUS" = "failed" ]; then
       echo "Tenant failed, deleting and recreating..."
       kubectl delete -f ob-deploy/tenant.yaml  -n oceanbase
       sleep 10
       kubectl apply -f ob-deploy/tenant.yaml -n oceanbase
   else
       echo "Current tenant status: $STATUS"
       kubectl get obtenant -n oceanbase
   fi

   sleep 5
done
# 导入数据库
kubectl apply -f init_job.yaml -ncsd
kubectl apply -f ob-deploy/oceanbase-todo.yaml -noceanbase
kubectl apply -f ssls/dz.api.caishuida.com.yaml -ncsd
kubectl apply -f ssls/dz.caishuida.com.yaml -ncsd
kubectl apply -f ssls/secret-origindz.caishuida.com.yaml -ncsd
# 安装中间件

helm install server-middle  ./server-middle -ncsd
helm install csdapp  ./dz-server -ncsd
