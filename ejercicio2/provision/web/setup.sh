#!/bin/bash

echo "Aprovisionando instancia Web..."
echo "Actualizando repositorios..."
apt-get update
ex +"%s@DPkg@//DPkg" -cwq /etc/apt/apt.conf.d/70debconf
dpkg-reconfigure debconf -f noninteractive -p critical
echo "Instalando Git..."
apt-get install git -y > /dev/null
echo "Instalando Nginx..."
apt-get install nginx -y > /dev/null
echo "Configurando Web..."
cp /vagrant/provision/web/config/default /etc/nginx/sites-available/default
cd /var/www/html ; git clone https://github.com/Tombar/sample-app.git
cp /vagrant/provision/web/config/settings.php /var/www/html/sample-app/
/etc/init.d/nginx restart > /dev/null
echo "Configurando Monitor..."
apt-get install curl -y
cp /vagrant/provision/monitor.sh /srv/
crontab /vagrant/provision/cronfile
echo "Instalando Postfix..."
export DEBIAN_FRONTEND=noninteractive
apt-get remove exim4  exim4-base exim4-config exim4-daemon-light -y > /dev/null
apt-get install postfix mailutils libsasl2-2 ca-certificates libsasl2-modules -y > /dev/null
mkdir -p /etc/postfix/sasl; cp /vagrant/provision/web/config/sasl_passwd /etc/postfix/sasl ; chmod 400 /etc/postfix/sasl/sasl_passwd ; postmap /etc/postfix/sasl/sasl_passwd ; cp /vagrant/provision/web/config/main.cf /etc/postfix/
/etc/init.d/postfix restart > /dev/null
