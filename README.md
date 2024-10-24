安装ubuntu22.04
dns 调整为114.114.114.114
安装k3s
安装helm
2. local-path
2. cert-manager
3. ob-deploy
4. server-middle
5. dz-server







# 1. 安装 Git LFS
# Windows
git lfs install

# Linux
curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash
sudo apt-get install git-lfs
git lfs install

# 2. 在仓库中设置 LFS 跟踪大文件
cd your-repository
git lfs track "*.sql"    # 跟踪所有 SQL 文件
# 或者具体指定文件
git lfs track "2020410231523/ncloud-global-tenant.sql"

# 3. 确保 .gitattributes 文件被提交
git add .gitattributes
git commit -m "build: add git lfs tracking"

# 4. 重新添加大文件
git add 2020410231523/ncloud-global-tenant.sql
git commit -m "feat: add database sql file"

# 5. 推送到远程仓库
git push origin master