### Configure Apache Server
> #### # vim /etc/apache2/mods-available/status.conf
Verificar se tem o conteúdo abaixo:
```
 <Location /server-status>
 SetHandler server-status
 Require local
 #Require ip 192.168.0.0/24
 </Location>
```
---
### Zabbix Agent Node
> /etc/zabbix/zabbix_agentd.conf:
```
# Script Apache
UserParameter=apache[*],/usr/local/share/zabbix/externalscripts/apache.sh '$1'
```
* Criar pasta script, baixar script, dar permissão e tornar executável:
```
mkdir -p /usr/local/share/zabbix/externalscripts
wget https://raw.githubusercontent.com/mindsecurity/zabbix-all/master/templates/userParameter/apache/apache.sh -O /usr/local/share/zabbix/externalscripts/apache.sh
chown -R zabbix:zabbix /usr/local/share/zabbix
chmod +x /usr/local/share/zabbix/externalscripts/apache.sh
```
* Reiniciando os serviços e importando o template:
```
systemctl restart zabbix-agent apache2
wget https://raw.githubusercontent.com/mindsecurity/zabbix-all/master/templates/userParameter/apache/zbx_template_apache.xml
```
* Só associar ao host monitorado.
