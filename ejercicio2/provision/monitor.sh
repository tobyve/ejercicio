#!/bin/bash

EMAIL="alberto.valdivieso@gmail.com"
REQUEST=`curl --silent GET http://10.127.0.10/sample-app/`
if [[ ${REQUEST} != "Hello World" ]]; then
	echo "Alarma: Sitio de Ejercicio 2 caido" | mail -s "Alarma : Sitio caido" ${EMAIL}
fi
