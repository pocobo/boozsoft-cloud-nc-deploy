k3s 国内和自建
https://forums.rancher.cn/t/k3s/1416



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


# crictl info
    "registry": {
      "configPath": "",
      "mirrors": {
        "docker.io": {
          "endpoint": [
            "https://docker.mirrors.ustc.edu.cn",
            "https://registry-1.docker.io"
          ],
          "rewrite": null
        }
      },