#!/usr/bin/env bashio

# Просто запускаем с дефолтными параметрами если проблемы
/app/TorrServer \
    -p 8090 \
    -s 8091 \
    -t 49165 \
    -ct 512 \
    -ll info \
    -d /data/torrserver