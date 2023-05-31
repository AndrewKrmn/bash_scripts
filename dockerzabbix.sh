mkdir /var/lib/zabbix/ && cd /var/lib/zabbix/ && ln -s /usr/share/zoneinfo/Europe/Kiev localtime && echo 'Europe/Kiev' > timezone && sudo docker network create zabbix-net 

sudo docker run --restart=always -d \
--name zabbix-postgres \
--network zabbix-net \
-v /var/lib/zabbix/timezone:/etc/timezone \
-v /var/lib/zabbix/localtime:/etc/localtime \
-e POSTGRES_PASSWORD=zabbix \
-e POSTGRES_USER=zabbix \
-d chikibevchik/zabbix:postgres


sudo docker run --restart=always \
--name zabbix-server \
--network zabbix-net \
-v /var/lib/zabbix/alertscripts:/usr/lib/zabbix/alertscripts \
-v /var/lib/zabbix/timezone:/etc/timezone \
-v /var/lib/zabbix/localtime:/etc/localtime \
-p 10051:10051 -e DB_SERVER_HOST="zabbix-postgres" \
-e POSTGRES_USER="zabbix" \
-e POSTGRES_PASSWORD="zabbix" \
-d chikibevchik/zabbix:server


sudo docker run --restart=always \
--name zabbix-web \
-p 80:8080 -p 443:8443 \
--network zabbix-net \
-e DB_SERVER_HOST="zabbix-postgres" \
-v /var/lib/zabbix/timezone:/etc/timezone \
-v /var/lib/zabbix/localtime:/etc/localtime \
-e POSTGRES_USER="zabbix" \
-e POSTGRES_PASSWORD="zabbix" \
-e ZBX_SERVER_HOST="zabbix-server" \
-e PHP_TZ="Europe/Kiev" \
-d chikibevchik/zabbix:web
