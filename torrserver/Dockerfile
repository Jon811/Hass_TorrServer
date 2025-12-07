# torrserver/Dockerfile
ARG BUILD_FROM
FROM $BUILD_FROM

# Метаданные
LABEL \
  maintainer="Jon811" \
  org.label-schema.name="TorrServer HA Addon" \
  org.label-schema.version="MatriX.136"

# Установка зависимостей
RUN apk add --no-cache \
    wget \
    tar \
    gzip \
    libc6-compat \
    ca-certificates \
    tzdata \
    && update-ca-certificates \
    && rm -rf /var/cache/apk/* /tmp/*

# Создание структуры каталогов
WORKDIR /app
RUN mkdir -p /data /config

# Определение архитектуры и скачивание TorrServer v136
ARG TORRSERVER_VERSION="136"
ARG BUILD_ARCH

# Сопоставление архитектур Home Assistant с архитектурами TorrServer
RUN case "${BUILD_ARCH}" in \
    "aarch64") TARGET_ARCH="arm64" ;; \
    "amd64") TARGET_ARCH="amd64" ;; \
    "armhf") TARGET_ARCH="arm" ;; \
    "armv7") TARGET_ARCH="arm7" ;; \
    "i386") TARGET_ARCH="386" ;; \
    *) echo "Unsupported architecture: ${BUILD_ARCH}" && exit 1 ;; \
    esac && \
    echo "Downloading TorrServer v${TORRSERVER_VERSION} for ${TARGET_ARCH}..." && \
    wget -q --show-progress \
      "https://github.com/YouROK/TorrServer/releases/download/MatriX.${TORRSERVER_VERSION}/TorrServer-linux-${TARGET_ARCH}" \
      -O /app/TorrServer && \
    chmod +x /app/TorrServer && \
    echo "TorrServer v${TORRSERVER_VERSION} installed successfully"

# Копирование скрипта запуска
COPY run.sh /
RUN chmod a+x /run.sh

# Создание пользователя для безопасности
RUN adduser -D -u 1000 torruser && \
    chown -R torruser:torruser /app /data /config && \
    mkdir -p /data/torrserver && \
    chown -R torruser:torruser /data/torrserver

USER torruser

# Переменные среды
ENV TZ=UTC \
    PUID=1000 \
    PGID=1000

# Точка входа
ENTRYPOINT ["/run.sh"]