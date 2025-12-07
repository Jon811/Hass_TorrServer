#!/usr/bin/env bashio
# torrserver/run.sh

bashio::log.info "Starting TorrServer add-on..."

# Ждем немного для инициализации
sleep 2

# Получаем параметры из конфигурации
PORT=$(bashio::config 'port' '8090')
STREAM_PORT=$(bashio::config 'stream_port' '8091')
TORRENT_PORT=$(bashio::config 'torrent_port' '49165')
CACHE_SIZE=$(bashio::config 'cache_size' '512')
LOG_LEVEL=$(bashio::config 'log_level' 'info')

# Формируем команду запуска
CMD="/app/TorrServer \
    -p ${PORT} \
    -s ${STREAM_PORT} \
    -t ${TORRENT_PORT} \
    -ct ${CACHE_SIZE} \
    -ll ${LOG_LEVEL} \
    -d /data/torrserver"

bashio::log.info "Command: ${CMD}"

# Запускаем TorrServer
exec ${CMD}