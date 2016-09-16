#! /bin/bash

command -v dig >/dev/null 2>&1 || { echo >&2 "Este programa requiere el programa Dig, el cual está instalado en la mayoria de distribuciones Linux,  ejecute como usuario root en Debian/Ubuntu --- apt-get install dnsutils ---"; exit 1; }
command -v curl >/dev/null 2>&1 || { echo >&2 "Este programa requiere el programa Dig, el cual está instalado en la mayoria de distribuciones Linux,  ejecute como usuario root en Debian/Ubuntu --- apt-get install curl ---"; exit 1; }

URLSRC="imujer.com"
URLDST="http://199.34.125.35/test"
EMAIL="alberto.valdivieso@gmail.com"

my_array=( `dig ${URLSRC} +short` )
for element in "${my_array[@]}"
do
        URL="${URLDST}?correo=${EMAIL}&record=${element}"
	var=`curl -X GET --write-out "%{http_code}\n" --silent --output /dev/null ${URL}`
	echo Respuesta con record ${element} http:$var
done
