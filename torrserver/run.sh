#!/usr/bin/env bashio
# torrserver/run.sh

CONFIG_PATH=/data/options.json
TORRSERVER_OPTS=""

# Получение настроек из Home Assistant
PORT=$(bashio::config 'port')
STREAM_PORT=$(bashio::config 'stream_port')
TORRENT_PORT=$(bashio::config 'torrent_port')
CACHE_SIZE=$(bashio::config 'cache_size')
LOG_LEVEL=$(bashio::config 'log_level')
DISABLE_TLS=$(bashio::config 'disable_tls')
DISABLE_ENCRYPTION=$(bashio::config 'disable_encryption')
PRELOAD_CACHE=$(bashio::config 'preload_cache')
DISABLE_UDP=$(bashio::config 'disable_udp')
DISABLE_TCP=$(bashio::config 'disable_tcp')
DISABLE_DHT=$(bashio::config 'disable_dht')
DISABLE_PEX=$(bashio::config 'disable_pex')
DISABLE_TRACKERS=$(bashio::config 'disable_trackers')
READ_TIMEOUT=$(bashio::config 'read_timeout')
WRITE_TIMEOUT=$(bashio::config 'write_timeout')
RDB=$(bashio::config 'rdb')
TORRENT_OPTIONS=$(bashio::config 'torrent_options')

# Формирование параметров запуска
TORRSERVER_OPTS="${TORRSERVER_OPTS} -p ${PORT:-8090}"
TORRSERVER_OPTS="${TORRSERVER_OPTS} -s ${STREAM_PORT:-8091}"

if [ -n "${TORRENT_PORT}" ] && [ "${TORRENT_PORT}" != "0" ]; then
    TORRSERVER_OPTS="${TORRSERVER_OPTS} -t ${TORRENT_PORT}"
else
    TORRSERVER_OPTS="${TORRSERVER_OPTS} -t 49165"
fi

if [ -n "${CACHE_SIZE}" ]; then
    TORRSERVER_OPTS="${TORRSERVER_OPTS} -ct ${CACHE_SIZE}"
fi

if [ -n "${LOG_LEVEL}" ]; then
    TORRSERVER_OPTS="${TORRSERVER_OPTS} -ll ${LOG_LEVEL}"
fi

# Булевые опции
[ "${DISABLE_TLS}" = "true" ] && TORRSERVER_OPTS="${TORRSERVER_OPTS} -dt"
[ "${DISABLE_ENCRYPTION}" = "true" ] && TORRSERVER_OPTS="${TORRSERVER_OPTS} -de"
[ "${PRELOAD_CACHE}" = "true" ] && TORRSERVER_OPTS="${TORRSERVER_OPTS} -pc"
[ "${DISABLE_UDP}" = "true" ] && TORRSERVER_OPTS="${TORRSERVER_OPTS} -du"
[ "${DISABLE_TCP}" = "true" ] && TORRSERVER_OPTS="${TORRSERVER_OPTS} -dtcp"
[ "${DISABLE_DHT}" = "true" ] && TORRSERVER_OPTS="${TORRSERVER_OPTS} -dd"
[ "${DISABLE_PEX}" = "true" ] && TORRSERVER_OPTS="${TORRSERVER_OPTS} -dpex"
[ "${DISABLE_TRACKERS}" = "true" ] && TORRSERVER_OPTS="${TORRSERVER_OPTS} -dtr"
[ "${RDB}" = "true" ] && TORRSERVER_OPTS="${TORRSERVER_OPTS} -rdb"

# Опции с числовыми значениями
[ -n "${READ_TIMEOUT}" ] && TORRSERVER_OPTS="${TORRSERVER_OPTS} -rt ${READ_TIMEOUT}"
[ -n "${WRITE_TIMEOUT}" ] && TORRSERVER_OPTS="${TORRSERVER_OPTS} -wt ${WRITE_TIMEOUT}"

# Дополнительные опции
[ -n "${TORRENT_OPTIONS}" ] && TORRSERVER_OPTS="${TORRSERVER_OPTS} ${TORRENT_OPTIONS}"

# Создание необходимых директорий
mkdir -p /data/torrserver/{db,cache,torrents,logs}
chmod -R 755 /data/torrserver

# Запуск TorrServer
cd /app
exec ./TorrServer ${TORRSERVER_OPTS} -d /data/torrserver