#!/usr/bin/with-contenv bashio
# run.sh для TorrServer с поддержкой s6-overlay

# Ждем инициализации s6-overlay
sleep 2

bashio::log.info "========================================"
bashio::log.info "Starting TorrServer Add-on"
bashio::log.info "========================================"

# Базовая конфигурация
PORT=8090
DATA_PATH="/data"
TORRENT_ADDR=":49165"  # ← ДОБАВЛЕНО

# Если есть конфиг HA
if [ -f /data/options.json ]; then
    bashio::log.info "Reading configuration from Home Assistant..."
    
    # Основные параметры
    PORT=$(grep -o '"port":[^,}]*' /data/options.json | cut -d: -f2 | tr -d ' "' || echo "8090")
    DATA_PATH=$(grep -o '"path":[^,}]*' /data/options.json | cut -d: -f2 | tr -d ' "' || echo "/data")
    TORRENT_ADDR=$(grep -o '"torrentaddr":"[^"]*"' /data/options.json | cut -d'"' -f4 || echo ":49165")  # ← ОБНОВЛЕНО
    
    # Дополнительные параметры
    IP=$(grep -o '"ip":"[^"]*"' /data/options.json | cut -d'"' -f4)
    SSL=$(grep -o '"ssl":[^,}]*' /data/options.json | cut -d: -f2 | tr -d ' "')
    SSLPORT=$(grep -o '"sslport":[^,}]*' /data/options.json | cut -d: -f2 | tr -d ' "')
    TORRENTS_DIR=$(grep -o '"torrentsdir":"[^"]*"' /data/options.json | cut -d'"' -f4)
    RDB=$(grep -o '"rdb":[^,}]*' /data/options.json | cut -d: -f2 | tr -d ' "')
    HTTPAUTH=$(grep -o '"httpauth":[^,}]*' /data/options.json | cut -d: -f2 | tr -d ' "')
    DONTKILL=$(grep -o '"dontkill":[^,}]*' /data/options.json | cut -d: -f2 | tr -d ' "')
    UI=$(grep -o '"ui":[^,}]*' /data/options.json | cut -d: -f2 | tr -d ' "')
    MAXSIZE=$(grep -o '"maxsize":[^,}]*' /data/options.json | cut -d: -f2 | tr -d ' "')
fi

# Формируем команду
CMD="/app/TorrServer --port=${PORT} --path=${DATA_PATH}"

# Обязательно добавляем TORRENT_ADDR если указан
if [ -n "$TORRENT_ADDR" ]; then
    CMD="$CMD --torrentaddr=${TORRENT_ADDR}"
fi

# Добавляем опциональные параметры
[ -n "$IP" ] && CMD="$CMD --ip=${IP}"
[ "$SSL" = "true" ] && CMD="$CMD --ssl"
[ -n "$SSLPORT" ] && CMD="$CMD --sslport=${SSLPORT}"
[ -n "$TORRENTS_DIR" ] && CMD="$CMD --torrentsdir=${TORRENTS_DIR}"
[ "$RDB" = "true" ] && CMD="$CMD --rdb"
[ "$HTTPAUTH" = "true" ] && CMD="$CMD --httpauth"
[ "$DONTKILL" = "true" ] && CMD="$CMD --dontkill"
[ "$UI" = "true" ] && CMD="$CMD --ui"
[ -n "$MAXSIZE" ] && CMD="$CMD --maxsize=${MAXSIZE}"

bashio::log.info "Starting TorrServer..."
bashio::log.info "Port: ${PORT}"
bashio::log.info "Data path: ${DATA_PATH}"
bashio::log.info "Torrent address: ${TORRENT_ADDR}"

# Запускаем
exec $CMD