FROM centos:7

# 配置阿里云镜像源
RUN cd /etc/yum.repos.d/ && \
    sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-* && \
    sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://mirrors.aliyun.com|g' /etc/yum.repos.d/CentOS-* && \
    yum clean all && \
    yum makecache

# 安装 OpenJDK 8 和 obclient
RUN yum update -y && \
    yum install -y java-1.8.0-openjdk-headless && \
    yum clean all

# 设置工作目录
WORKDIR /app

# 复制 ob-loader-dumper 和 obclient
COPY ob-loader-dumper-4.3.1.1-RELEASE.tar.gz /app/
COPY obclient-2.2.6-1.el7.x86_64.rpm /app/

# 安装 obclient
RUN rpm -ivh obclient-2.2.6-1.el7.x86_64.rpm && \
    rm obclient-2.2.6-1.el7.x86_64.rpm

# 解压 ob-loader-dumper 并清理
RUN tar -xzf ob-loader-dumper-4.3.1.1-RELEASE.tar.gz && \
    rm ob-loader-dumper-4.3.1.1-RELEASE.tar.gz

# 设置 JVM 参数
ENV JAVA_OPTS="-server -Xms8G -Xmx8G -XX:MetaspaceSize=128M -XX:MaxMetaspaceSize=128M -Xss352K \
    -XX:+UnlockExperimentalVMOptions -XX:+UseG1GC -Xnoclassgc -XX:+DisableExplicitGC"

# 创建数据目录
RUN mkdir -p /app/data

ENV DB_HOST="192.168.199.169" \
    DB_USER="root@metatenant#metadb" \
    DB_PORT="30883" \
    DB_PASSWORD="rootpass" \
    DB_NAME="oceanbase" \
    SYS_USER="root" \
    SYS_PASSWORD="rootpass"

#    docker run \
#        -e DB_HOST="192.168.199.169" \
#        -e DB_USER="root@metatenant#metadb" \
#        -e DB_PORT="30883" \
#        -e DB_PASSWORD="rootpass" \
#        -e DB_NAME="oceanbase" \
#        -e SYS_USER="root" \
#        -e SYS_PASSWORD="rootpass" \
#        data1

# 设置快捷命令的脚本
RUN echo '#!/bin/bash\n\
obclient -h192.168.199.169 -P30883 -uroot@metatenant#metadb -prootpass hello' > /app/connect.sh \
    && chmod +x /app/connect.sh
COPY sqls /app/sqls
COPY start.sh /app/
RUN chmod +x /app/start.sh

ENV JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.412.b08-1.el7_9.x86_64/jre
ENV JRE_HOME=/usr/lib/jvm/jre-1.8.0-openjdk-1.8.0.412.b08-1.el7_9.x86_64/jre
# 保持容器运行
#CMD ["./start.sh"]
CMD ["tail", "-f", "/dev/null"]