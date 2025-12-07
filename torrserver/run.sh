#!/usr/bin/with-contenv bashio

# Просто запускаем с параметрами из HA
/app/TorrServer \
    -p "$(bashio::config 'port' '8090')" \
    -s "$(bashio::config 'stream_port' '8091')" \
    -d /data/torrserver