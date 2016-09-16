#!/bin/bash

# Cron 
cron="*/5 * * * * /srv/monitor.sh"

# Escape 
cron_escaped=$(echo "$cron" | sed s/\*/\\\\*/g)

# Revisar si existe el cron 
crontab -l | grep "${cronescaped}"
if [[ $? -eq 0 ]] ;
  then
    echo "Crontab existe..."
    exit
  else
    # Copiar cron a archivo temporal 
    crontab -l > mycron
    # Agregar cron 
    echo "$cron" >> mycron
    # Instalar cron 
    crontab mycron
    # Eliminar archivo temporal 
 ##   rm mycron
fi
