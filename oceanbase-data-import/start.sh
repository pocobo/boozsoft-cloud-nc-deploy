#!/bin/bash
echo "开始导入数据"

# 创建数据库（注意使用反引号括起带连字符的数据库名）
obclient -h192.168.199.169 -uroot@metatenant#metadb -P30883 -prootpass -c -A oceanbase -e "CREATE DATABASE hello;"
obclient -h192.168.199.169 -uroot@metatenant#metadb -P30883 -prootpass -c -A oceanbase -e "CREATE DATABASE \`ncloud-global-meta\`;"
obclient -h192.168.199.169 -uroot@metatenant#metadb -P30883 -prootpass -c -A oceanbase -e "CREATE DATABASE \`ncloud-global-org\`;"
obclient -h192.168.199.169 -uroot@metatenant#metadb -P30883 -prootpass -c -A oceanbase -e "CREATE DATABASE \`ncloud-global-template\`;"
obclient -h192.168.199.169 -uroot@metatenant#metadb -P30883 -prootpass -c -A oceanbase -e "CREATE DATABASE \`ncloud-global-tenant\`;"
obclient -h192.168.199.169 -uroot@metatenant#metadb -P30883 -prootpass -c -A oceanbase -e "CREATE DATABASE \`ncloud-global-tenant01\`;"
obclient -h192.168.199.169 -uroot@metatenant#metadb -P30883 -prootpass -c -A oceanbase -e "CREATE DATABASE \`ncloud-global-tenant01-fp\`;"
obclient -h192.168.199.169 -uroot@metatenant#metadb -P30883 -prootpass -c -A oceanbase -e "CREATE DATABASE \`ncloud-global-tenant02\`;"
obclient -h192.168.199.169 -uroot@metatenant#metadb -P30883 -prootpass -c -A oceanbase -e "CREATE DATABASE \`ncloud-global-tenant02-fp\`;"
obclient -h192.168.199.169 -uroot@metatenant#metadb -P30883 -prootpass -c -A oceanbase -e "CREATE DATABASE \`ncloud-global-tenant03\`;"
obclient -h192.168.199.169 -uroot@metatenant#metadb -P30883 -prootpass -c -A oceanbase -e "CREATE DATABASE \`ncloud-global-tenant03-fp\`;"
obclient -h192.168.199.169 -uroot@metatenant#metadb -P30883 -prootpass -c -A oceanbase -e "CREATE DATABASE \`ncloud-global-tenant-fp\`;"
obclient -h192.168.199.169 -uroot@metatenant#metadb -P30883 -prootpass -c -A oceanbase -e "CREATE DATABASE \`ncloud-nacos\`;"
/app/ob-loader-dumper-4.3.1.1-RELEASE/bin/obloader -h 192.168.199.169 -P 30883 -u root@metatenant#metadb -p 'rootpass' --sys-user root --sys-password rootpass -D hello --ddl --all -f sqls/hello
/app/ob-loader-dumper-4.3.1.1-RELEASE/bin/obloader -h 192.168.199.169 -P 30883 -u root@metatenant#metadb -p 'rootpass' --sys-user root --sys-password rootpass -D ncloud-global-meta --ddl --all -f sqls/ncloud-global-meta
/app/ob-loader-dumper-4.3.1.1-RELEASE/bin/obloader -h 192.168.199.169 -P 30883 -u root@metatenant#metadb -p 'rootpass' --sys-user root --sys-password rootpass -D ncloud-global-org --ddl --all -f sqls/ncloud-global-org
/app/ob-loader-dumper-4.3.1.1-RELEASE/bin/obloader -h 192.168.199.169 -P 30883 -u root@metatenant#metadb -p 'rootpass' --sys-user root --sys-password rootpass -D ncloud-global-template --ddl --all -f sqls/ncloud-global-template
/app/ob-loader-dumper-4.3.1.1-RELEASE/bin/obloader -h 192.168.199.169 -P 30883 -u root@metatenant#metadb -p 'rootpass' --sys-user root --sys-password rootpass -D ncloud-global-tenant --ddl --all -f sqls/ncloud-global-tenant
/app/ob-loader-dumper-4.3.1.1-RELEASE/bin/obloader -h 192.168.199.169 -P 30883 -u root@metatenant#metadb -p 'rootpass' --sys-user root --sys-password rootpass -D ncloud-global-tenant01 --ddl --all -f sqls/ncloud-global-tenant01
/app/ob-loader-dumper-4.3.1.1-RELEASE/bin/obloader -h 192.168.199.169 -P 30883 -u root@metatenant#metadb -p 'rootpass' --sys-user root --sys-password rootpass -D ncloud-global-tenant01-fp --ddl --all -f sqls/ncloud-global-tenant01-fp
/app/ob-loader-dumper-4.3.1.1-RELEASE/bin/obloader -h 192.168.199.169 -P 30883 -u root@metatenant#metadb -p 'rootpass' --sys-user root --sys-password rootpass -D ncloud-global-tenant02 --ddl --all -f sqls/ncloud-global-tenant02
/app/ob-loader-dumper-4.3.1.1-RELEASE/bin/obloader -h 192.168.199.169 -P 30883 -u root@metatenant#metadb -p 'rootpass' --sys-user root --sys-password rootpass -D ncloud-global-tenant02-fp --ddl --all -f sqls/ncloud-global-tenant02-fp
/app/ob-loader-dumper-4.3.1.1-RELEASE/bin/obloader -h 192.168.199.169 -P 30883 -u root@metatenant#metadb -p 'rootpass' --sys-user root --sys-password rootpass -D ncloud-global-tenant03 --ddl --all -f sqls/ncloud-global-tenant03
/app/ob-loader-dumper-4.3.1.1-RELEASE/bin/obloader -h 192.168.199.169 -P 30883 -u root@metatenant#metadb -p 'rootpass' --sys-user root --sys-password rootpass -D ncloud-global-tenant03-fp --ddl --all -f sqls/ncloud-global-tenant03-fp
/app/ob-loader-dumper-4.3.1.1-RELEASE/bin/obloader -h 192.168.199.169 -P 30883 -u root@metatenant#metadb -p 'rootpass' --sys-user root --sys-password rootpass -D ncloud-global-tenant-fp --ddl --all -f sqls/ncloud-global-tenant-fp
/app/ob-loader-dumper-4.3.1.1-RELEASE/bin/obloader -h 192.168.199.169 -P 30883 -u root@metatenant#metadb -p 'rootpass' --sys-user root --sys-password rootpass -D ncloud-nacos --ddl --all -f sqls/ncloud-nacos
