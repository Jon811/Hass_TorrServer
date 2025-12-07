#!/usr/bin/env bashio

bashio::log.info "Starting TorrServer..."

# Базовые параметры
PORT=$(bashio::config 'port' 8090)
STREAM_PORT=$(bashio::config 'stream_port' 8091)
TORRENT_PORT=$(bashio::config 'torrent_port' 49165)
CACHE_SIZE=$(bashio::config 'cache_size' 512)

# Запуск
exec /app/TorrServer \
  -p "${PORT}" \
  -s "${STREAM_PORT}" \
  -t "${TORRENT_PORT}" \
  -ct "${CACHE_SIZE}" \
  -d /data/torrserver