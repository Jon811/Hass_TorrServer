ARG BUILD_FROM=ghcr.io/home-assistant/amd64-addon-base:16.2.0
FROM ${BUILD_FROM}

WORKDIR /app

# Переменные окружения
ARG TORRSERVER_VERSION="136"
ARG BUILD_ARCH

# Конвертация архитектур HA → TorrServer
RUN case "${BUILD_ARCH}" in \
        aarch64) TARGET_ARCH="arm64" ;; \
        armhf)   TARGET_ARCH="arm" ;; \
        armv7)   TARGET_ARCH="arm7" ;; \
        i386)    TARGET_ARCH="386" ;; \
        amd64)   TARGET_ARCH="amd64" ;; \
        *) echo "Unknown arch: ${BUILD_ARCH}" && exit 1 ;; \
    esac && \
    wget -q \
    "https://github.com/YouROK/TorrServer/releases/download/MatriX.${TORRSERVER_VERSION}/TorrServer-linux-${TARGET_ARCH}" && \
    mv "TorrServer-linux-${TARGET_ARCH}" /app/TorrServer && \
    chmod +x /app/TorrServer

# Добавляем службу для S6 Overlay
RUN mkdir -p /etc/services.d/torrserver
COPY run.sh /etc/services.d/torrserver/run
RUN chmod +x /etc/services.d/torrserver/run
