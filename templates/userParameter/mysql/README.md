# MySQL via zabbix-agent
> ### /etc/zabbix/.my.cnf
```
[mysql]
user=monitdb
password=Monitdb123

[mysqladmin]
user=monitdb
password=Monitdb123
```
* Acessar console do mysql e dar acesso aos `databases` que serão monitorados:
```
mysql> GRANT USAGE ON *.* TO 'monitdb'@'localhost' IDENTIFIED BY 'Monitdb123' WITH GRANT OPTION;
```

* Baixar o arquivo para:
> ### /etc/zabbix/zabbix_agentd.conf.d/
```
wget https://raw.githubusercontent.com/mindsecurity/zabbix-all/master/templates/userParameter/mysql/userparameters_mysql.conf -O /etc/zabbix/zabbix_agentd.conf.d/userparameters_mysql.conf
```
* Adicionar ao zabbix_agentd.conf
```
### Option: Include
Include=/etc/zabbix/zabbix_agentd.conf.d/
```
* Reinicie o zabbix-agent.service
* Testes com o `zabbix_get`:
```
# zabbix_get -s 127.0.0.1 -k mysql.status[Com_insert]
# zabbix_get -s 127.0.0.1 -k mysql.version
# zabbix_get -s 127.0.0.1 -k mysql.ping
# zabbix_get -s 127.0.0.1 -k mysql.size
# zabbix_get -s 127.0.0.1 -k mysql.size[zabbix]
# zabbix_get -s 127.0.0.1 -k mysql.size[zabbix,hosts]
```
* Associar o `Template App MySQL` ao host que executa o servidor MySQL
