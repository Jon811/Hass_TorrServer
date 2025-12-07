#!/usr/bin/env bashio

bashio::log.info "Starting TorrServer..."

exec /app/TorrServer \
    -p "$(bashio::config 'port' '8090')" \
    -s "$(bashio::config 'stream_port' '8091')" \
    -t "$(bashio::config 'torrent_port' '49165')" \
    -ct "$(bashio::config 'cache_size' '512')" \
    -d /data/torrserver
