#!/usr/bin/with-contenv bashio

# Получаем параметры из конфигурации Home Assistant
PORT=$(bashio::config 'port')
STREAM_PORT=$(bashio::config 'stream_port')
TORRENT_PORT=$(bashio::config 'torrent_port')
CACHE_SIZE=$(bashio::config 'cache_size')

# Устанавливаем значения по умолчанию
: "${PORT:=8090}"
: "${STREAM_PORT:=8091}"
: "${TORRENT_PORT:=49165}"
: "${CACHE_SIZE:=512}"

# Запускаем TorrServer
exec /app/TorrServer \
    -p "${PORT}" \
    -s "${STREAM_PORT}" \
    -t "${TORRENT_PORT}" \
    -ct "${CACHE_SIZE}" \
    -d /data/torrserver