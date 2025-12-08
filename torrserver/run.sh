#!/usr/bin/with-contenv bashio

bashio::log.info "Starting TorrServer..."

PORT=$(bashio::config 'port')
DATA_PATH=$(bashio::config 'path')
TORRENTADDR=$(bashio::config 'torrentaddr')
IP=$(bashio::config 'ip')
SSL=$(bashio::config 'ssl')
SSLPORT=$(bashio::config 'sslport')
TORRENTS_DIR=$(bashio::config 'torrentsdir')
RDB=$(bashio::config 'rdb')
HTTPAUTH=$(bashio::config 'httpauth')
DONTKILL=$(bashio::config 'dontkill')
UI=$(bashio::config 'ui')
MAXSIZE=$(bashio::config 'maxsize')

CMD="/app/TorrServer --port=${PORT} --path=${DATA_PATH} --torrentaddr=${TORRENTADDR}"

[ -n "$IP" ] && CMD="${CMD} --ip=${IP}"
[ "$SSL" = "true" ] && CMD="${CMD} --ssl"
[ -n "$SSLPORT" ] && CMD="${CMD} --sslport=${SSLPORT}"
[ -n "$TORRENTS_DIR" ] && CMD="${CMD} --torrentsdir=${TORRENTS_DIR}"
[ "$RDB" = "true" ] && CMD="${CMD} --rdb"
[ "$HTTPAUTH" = "true" ] && CMD="${CMD} --httpauth"
[ "$DONTKILL" = "true" ] && CMD="${CMD} --dontkill"
[ "$UI" = "true" ] && CMD="${CMD} --ui"
[ "$MAXSIZE" -gt 0 ] && CMD="${CMD} --maxsize=${MAXSIZE}"

bashio::log.info "Command: ${CMD}"
exec ${CMD}
