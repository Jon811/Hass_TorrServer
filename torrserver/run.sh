#!/bin/bash
# run.sh для TorrServer MatriX.136+

# Значения по умолчанию
PORT=8090
TORRENT_PORT=49165
CACHE_SIZE=512
LOG_LEVEL="info"
EXTRA_OPTS=""

# Парсим конфиг HA если есть
if [ -f /data/options.json ]; then
    echo "Reading Home Assistant configuration..."
    
    # Базовые параметры
    PORT=$(grep -o '"port":[^,}]*' /data/options.json | cut -d: -f2 | tr -d ' "' || echo "8090")
    TORRENT_PORT=$(grep -o '"torrent_port":[^,}]*' /data/options.json | cut -d: -f2 | tr -d ' "' || echo "49165")
    CACHE_SIZE=$(grep -o '"cache_size":[^,}]*' /data/options.json | cut -d: -f2 | tr -d ' "' || echo "512")
    LOG_LEVEL=$(grep -o '"log_level":"[^"]*"' /data/options.json | cut -d'"' -f4 || echo "info")
    
    # Флаги
    if grep -q '"disable_tls":true' /data/options.json; then EXTRA_OPTS="$EXTRA_OPTS -dt"; fi
    if grep -q '"disable_encryption":true' /data/options.json; then EXTRA_OPTS="$EXTRA_OPTS -de"; fi
    if grep -q '"preload_cache":true' /data/options.json; then EXTRA_OPTS="$EXTRA_OPTS -pc"; fi
    if grep -q '"disable_udp":true' /data/options.json; then EXTRA_OPTS="$EXTRA_OPTS -du"; fi
    if grep -q '"disable_tcp":true' /data/options.json; then EXTRA_OPTS="$EXTRA_OPTS -dtcp"; fi
    if grep -q '"disable_dht":true' /data/options.json; then EXTRA_OPTS="$EXTRA_OPTS -dd"; fi
    if grep -q '"disable_pex":true' /data/options.json; then EXTRA_OPTS="$EXTRA_OPTS -dpex"; fi
    if grep -q '"disable_trackers":true' /data/options.json; then EXTRA_OPTS="$EXTRA_OPTS -dtr"; fi
    if grep -q '"rdb":true' /data/options.json; then EXTRA_OPTS="$EXTRA_OPTS -rdb"; fi
    
    # Числовые параметры
    READ_TIMEOUT=$(grep -o '"read_timeout":[^,}]*' /data/options.json | cut -d: -f2 | tr -d ' "')
    WRITE_TIMEOUT=$(grep -o '"write_timeout":[^,}]*' /data/options.json | cut -d: -f2 | tr -d ' "')
    [ -n "$READ_TIMEOUT" ] && EXTRA_OPTS="$EXTRA_OPTS -rt $READ_TIMEOUT"
    [ -n "$WRITE_TIMEOUT" ] && EXTRA_OPTS="$EXTRA_OPTS -wt $WRITE_TIMEOUT"
    
    # Дополнительные опции
    TORRENT_OPTIONS=$(grep -o '"torrent_options":"[^"]*"' /data/options.json | cut -d'"' -f4)
    [ -n "$TORRENT_OPTIONS" ] && EXTRA_OPTS="$EXTRA_OPTS $TORRENT_OPTIONS"
fi

# Формируем команду запуска (БЕЗ -s параметра!)
CMD="/app/TorrServer -p ${PORT} -t ${TORRENT_PORT} -ct ${CACHE_SIZE} -ll ${LOG_LEVEL}${EXTRA_OPTS} -d /data"

echo "========================================"
echo "Starting TorrServer MatriX.136"
echo "Port: ${PORT} (web interface & streaming)"
echo "Torrent port: ${TORRENT_PORT}"
echo "Cache: ${CACHE_SIZE}MB"
echo "Log level: ${LOG_LEVEL}"
echo "Extra options: ${EXTRA_OPTS}"
echo "========================================"

# Запускаем
exec $CMD