#!/usr/bin/with-contenv bashio

# Ждем готовности системы
sleep 3

# Базовые параметры (всегда требуются)
PORT=$(bashio::config 'port' "8090")
STREAM_PORT=$(bashio::config 'stream_port' "8091")
TORRENT_PORT=$(bashio::config 'torrent_port' "49165")
CACHE_SIZE=$(bashio::config 'cache_size' "512")

# Запускаем
exec /app/TorrServer \
    -p "${PORT}" \
    -s "${STREAM_PORT}" \
    -t "${TORRENT_PORT}" \
    -ct "${CACHE_SIZE}" \
    -d /data/torrserver