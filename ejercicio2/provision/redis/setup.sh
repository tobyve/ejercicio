#!/bin/bash

echo "Aprovisionando instancia Redis..."
echo "Actualizando repositorios..."
apt-get update
ex +"%s@DPkg@//DPkg" -cwq /etc/apt/apt.conf.d/70debconf
dpkg-reconfigure debconf -f noninteractive -p critical
echo "Instalando Redis..."
apt-get install redis-server -y > /dev/null
echo "Configurando Redis..."
cp /vagrant/provision/redis/config/redis.conf /etc/redis/
service redis-server restart > /dev/null
echo "Instalando Postfix..."
export DEBIAN_FRONTEND=noninteractive
apt-get remove exim4  exim4-base exim4-config exim4-daemon-light -y > /dev/null
apt-get install postfix mailutils libsasl2-2 ca-certificates libsasl2-modules -y > /dev/null
mkdir -p /etc/postfix/sasl; cp /vagrant/provision/web/config/sasl_passwd /etc/postfix/sasl ; chmod 400 /etc/postfix/sasl/sasl_passwd ; postmap /etc/postfix/sasl/sasl_passwd ; cp /vagrant/provision/web/config/main.cf /etc/postfix/
/etc/init.d/postfix restart > /dev/null
echo "Configurando Monitor..."
apt-get install curl -y
cp /vagrant/provision/monitor.sh /srv/
crontab /vagrant/provision/cronfile
