create database  `hello`;
create database `ncloud-global-meta`;
create database `ncloud-global-org`;
create database  `ncloud-global-template`;
create database `ncloud-global-tenant`;
create database `ncloud-global-tenant01`;
create database  `ncloud-global-tenant01-fp`;
create database `ncloud-global-tenant02`;
create database `ncloud-global-tenant02-fp`;
create database  `ncloud-global-tenant03`;
create database `ncloud-global-tenant03-fp`;
create database `ncloud-global-tenant-fp`;
create database  `ncloud-nacos`;

obclient -h192.168.199.169 -uroot@metatenant#metadb -P30883 -prootpass -c -A oceanbase -e "CREATE DATABASE hello;"
obclient -h192.168.199.169 -uroot@metatenant#metadb -P30883 -prootpass -c -A oceanbase -e "CREATE DATABASE ncloud-global-meta;"
obclient -h192.168.199.169 -uroot@metatenant#metadb -P30883 -prootpass -c -A oceanbase -e "CREATE DATABASE ncloud-global-org;"
obclient -h192.168.199.169 -uroot@metatenant#metadb -P30883 -prootpass -c -A oceanbase -e "CREATE DATABASE ncloud-global-template;"
obclient -h192.168.199.169 -uroot@metatenant#metadb -P30883 -prootpass -c -A oceanbase -e "CREATE DATABASE ncloud-global-tenant;"
obclient -h192.168.199.169 -uroot@metatenant#metadb -P30883 -prootpass -c -A oceanbase -e "CREATE DATABASE ncloud-global-tenant01;"
obclient -h192.168.199.169 -uroot@metatenant#metadb -P30883 -prootpass -c -A oceanbase -e "CREATE DATABASE ncloud-global-tenant01-fp;"
obclient -h192.168.199.169 -uroot@metatenant#metadb -P30883 -prootpass -c -A oceanbase -e "CREATE DATABASE ncloud-global-tenant02;"
obclient -h192.168.199.169 -uroot@metatenant#metadb -P30883 -prootpass -c -A oceanbase -e "CREATE DATABASE ncloud-global-tenant02-fp;"
obclient -h192.168.199.169 -uroot@metatenant#metadb -P30883 -prootpass -c -A oceanbase -e "CREATE DATABASE ncloud-global-tenant03;"
obclient -h192.168.199.169 -uroot@metatenant#metadb -P30883 -prootpass -c -A oceanbase -e "CREATE DATABASE ncloud-global-tenant03-fp;"
obclient -h192.168.199.169 -uroot@metatenant#metadb -P30883 -prootpass -c -A oceanbase -e "CREATE DATABASE ncloud-global-tenant-fp;"
obclient -h192.168.199.169 -uroot@metatenant#metadb -P30883 -prootpass -c -A oceanbase -e "CREATE DATABASE ncloud-nacos;"

