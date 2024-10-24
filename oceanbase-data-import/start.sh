#!/bin/bash
echo "开始导入数据"

# 创建数据库（注意使用反引号括起带连字符的数据库名）
obclient  -h${DB_HOST} -u${DB_USER} -P${DB_PORT} -p${DB_PASSWORD} -c -A ${DB_NAME} -e "CREATE DATABASE hello;"
obclient  -h${DB_HOST} -u${DB_USER} -P${DB_PORT} -p${DB_PASSWORD} -c -A ${DB_NAME} -e "CREATE DATABASE \`ncloud-global-meta\`;"
obclient  -h${DB_HOST} -u${DB_USER} -P${DB_PORT} -p${DB_PASSWORD} -c -A ${DB_NAME} -e "CREATE DATABASE \`ncloud-global-org\`;"
obclient  -h${DB_HOST} -u${DB_USER} -P${DB_PORT} -p${DB_PASSWORD} -c -A ${DB_NAME} -e "CREATE DATABASE \`ncloud-global-template\`;"
obclient  -h${DB_HOST} -u${DB_USER} -P${DB_PORT} -p${DB_PASSWORD} -c -A ${DB_NAME} -e "CREATE DATABASE \`ncloud-global-tenant\`;"
obclient  -h${DB_HOST} -u${DB_USER} -P${DB_PORT} -p${DB_PASSWORD} -c -A ${DB_NAME} -e "CREATE DATABASE \`ncloud-global-tenant01\`;"
obclient  -h${DB_HOST} -u${DB_USER} -P${DB_PORT} -p${DB_PASSWORD} -c -A ${DB_NAME} -e "CREATE DATABASE \`ncloud-global-tenant01-fp\`;"
obclient  -h${DB_HOST} -u${DB_USER} -P${DB_PORT} -p${DB_PASSWORD} -c -A ${DB_NAME} -e "CREATE DATABASE \`ncloud-global-tenant02\`;"
obclient  -h${DB_HOST} -u${DB_USER} -P${DB_PORT} -p${DB_PASSWORD} -c -A ${DB_NAME} -e "CREATE DATABASE \`ncloud-global-tenant02-fp\`;"
obclient  -h${DB_HOST} -u${DB_USER} -P${DB_PORT} -p${DB_PASSWORD} -c -A ${DB_NAME} -e "CREATE DATABASE \`ncloud-global-tenant03\`;"
obclient  -h${DB_HOST} -u${DB_USER} -P${DB_PORT} -p${DB_PASSWORD} -c -A ${DB_NAME} -e "CREATE DATABASE \`ncloud-global-tenant03-fp\`;"
obclient  -h${DB_HOST} -u${DB_USER} -P${DB_PORT} -p${DB_PASSWORD} -c -A ${DB_NAME} -e "CREATE DATABASE \`ncloud-global-tenant-fp\`;"
obclient  -h${DB_HOST} -u${DB_USER} -P${DB_PORT} -p${DB_PASSWORD} -c -A ${DB_NAME} -e "CREATE DATABASE \`ncloud-nacos\`;"
/app/ob-loader-dumper-4.3.1.1-RELEASE/bin/obloader -h ${DB_HOST} -P ${DB_PORT} -u ${DB_USER} -p '${DB_PASSWORD}' --sys-user root --sys-password ${DB_PASSWORD} -D hello --ddl --all -f sqls/hello
/app/ob-loader-dumper-4.3.1.1-RELEASE/bin/obloader -h ${DB_HOST} -P ${DB_PORT} -u ${DB_USER} -p '${DB_PASSWORD}' --sys-user root --sys-password ${DB_PASSWORD} -D ncloud-global-meta --ddl --all -f sqls/ncloud-global-meta
/app/ob-loader-dumper-4.3.1.1-RELEASE/bin/obloader -h ${DB_HOST} -P ${DB_PORT} -u ${DB_USER} -p '${DB_PASSWORD}' --sys-user root --sys-password ${DB_PASSWORD} -D ncloud-global-org --ddl --all -f sqls/ncloud-global-org
/app/ob-loader-dumper-4.3.1.1-RELEASE/bin/obloader -h ${DB_HOST} -P ${DB_PORT} -u ${DB_USER} -p '${DB_PASSWORD}' --sys-user root --sys-password ${DB_PASSWORD} -D ncloud-global-template --ddl --all -f sqls/ncloud-global-template
/app/ob-loader-dumper-4.3.1.1-RELEASE/bin/obloader -h ${DB_HOST} -P ${DB_PORT} -u ${DB_USER} -p '${DB_PASSWORD}' --sys-user root --sys-password ${DB_PASSWORD} -D ncloud-global-tenant --ddl --all -f sqls/ncloud-global-tenant
/app/ob-loader-dumper-4.3.1.1-RELEASE/bin/obloader -h ${DB_HOST} -P ${DB_PORT} -u ${DB_USER} -p '${DB_PASSWORD}' --sys-user root --sys-password ${DB_PASSWORD} -D ncloud-global-tenant01 --ddl --all -f sqls/ncloud-global-tenant01
/app/ob-loader-dumper-4.3.1.1-RELEASE/bin/obloader -h ${DB_HOST} -P ${DB_PORT} -u ${DB_USER} -p '${DB_PASSWORD}' --sys-user root --sys-password ${DB_PASSWORD} -D ncloud-global-tenant01-fp --ddl --all -f sqls/ncloud-global-tenant01-fp
/app/ob-loader-dumper-4.3.1.1-RELEASE/bin/obloader -h ${DB_HOST} -P ${DB_PORT} -u ${DB_USER} -p '${DB_PASSWORD}' --sys-user root --sys-password ${DB_PASSWORD} -D ncloud-global-tenant02 --ddl --all -f sqls/ncloud-global-tenant02
/app/ob-loader-dumper-4.3.1.1-RELEASE/bin/obloader -h ${DB_HOST} -P ${DB_PORT} -u ${DB_USER} -p '${DB_PASSWORD}' --sys-user root --sys-password ${DB_PASSWORD} -D ncloud-global-tenant02-fp --ddl --all -f sqls/ncloud-global-tenant02-fp
/app/ob-loader-dumper-4.3.1.1-RELEASE/bin/obloader -h ${DB_HOST} -P ${DB_PORT} -u ${DB_USER} -p '${DB_PASSWORD}' --sys-user root --sys-password ${DB_PASSWORD} -D ncloud-global-tenant03 --ddl --all -f sqls/ncloud-global-tenant03
/app/ob-loader-dumper-4.3.1.1-RELEASE/bin/obloader -h ${DB_HOST} -P ${DB_PORT} -u ${DB_USER} -p '${DB_PASSWORD}' --sys-user root --sys-password ${DB_PASSWORD} -D ncloud-global-tenant03-fp --ddl --all -f sqls/ncloud-global-tenant03-fp
/app/ob-loader-dumper-4.3.1.1-RELEASE/bin/obloader -h ${DB_HOST} -P ${DB_PORT} -u ${DB_USER} -p '${DB_PASSWORD}' --sys-user root --sys-password ${DB_PASSWORD} -D ncloud-global-tenant-fp --ddl --all -f sqls/ncloud-global-tenant-fp
/app/ob-loader-dumper-4.3.1.1-RELEASE/bin/obloader -h ${DB_HOST} -P ${DB_PORT} -u ${DB_USER} -p '${DB_PASSWORD}' --sys-user root --sys-password ${DB_PASSWORD} -D ncloud-nacos --ddl --all -f sqls/ncloud-nacos
