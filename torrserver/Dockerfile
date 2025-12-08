# torrserver/Dockerfile
ARG BUILD_FROM="ghcr.io/home-assistant/amd64-base:latest"
FROM ${BUILD_FROM}

# Устанавливаем wget (без file, он не нужен)
RUN apk add --no-cache \
    wget \
    ca-certificates \
    && rm -rf /var/cache/apk/*

WORKDIR /app

ARG TORRSERVER_VERSION="136"
ARG BUILD_ARCH="amd64"

# Определяем архитектуру для скачивания правильного бинарника
RUN set -e && \
    echo "Building for architecture: ${BUILD_ARCH}" && \
    case "${BUILD_ARCH}" in \
        aarch64) TARGET_ARCH="arm64" ;; \
        amd64)   TARGET_ARCH="amd64" ;; \
        armhf)   TARGET_ARCH="arm" ;; \
        armv7)   TARGET_ARCH="arm7" ;; \
        i386)    TARGET_ARCH="386" ;; \
        *) echo "ERROR: Unsupported architecture: ${BUILD_ARCH}" && exit 1 ;; \
    esac && \
    echo "Downloading TorrServer MatriX.${TORRSERVER_VERSION} for ${TARGET_ARCH}..." && \
    wget -q \
        "https://github.com/YouROK/TorrServer/releases/download/MatriX.${TORRSERVER_VERSION}/TorrServer-linux-${TARGET_ARCH}" && \
    mv "TorrServer-linux-${TARGET_ARCH}" TorrServer && \
    chmod +x TorrServer && \
    echo "TorrServer ${TORRSERVER_VERSION} for ${TARGET_ARCH} downloaded successfully"

# Упрощенная проверка бинарника (БЕЗ команды file)
RUN echo "Verifying binary..." && \
    ls -la /app/TorrServer && \
    [ -f /app/TorrServer ] && \
    [ -x /app/TorrServer ] && \
    echo "✓ Binary is ready and executable"

# Копируем скрипт запуска
COPY run.sh /
RUN chmod +x /run.sh

# Home Assistant сам запускает run.sh