#!/bin/bash

# 数据库连接信息
MYSQL_HOST="your-mysql-host"
MYSQL_USER="root"
MYSQL_PASSWORD="your-password"

# 备份配置
BACKUP_DIR="/backup"
DATE=$(date +%Y%m%d_%H%M%S)

# 导出所有数据库
mysqldump -h ${MYSQL_HOST} -u ${MYSQL_USER} -p${MYSQL_PASSWORD} --all-databases > ${BACKUP_DIR}/all_db_${DATE}.sql

# 压缩备份
gzip ${BACKUP_DIR}/all_db_${DATE}.sql

echo "Backup completed: all_db_${DATE}.sql.gz"