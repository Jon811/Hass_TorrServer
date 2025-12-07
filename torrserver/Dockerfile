# torrserver/Dockerfile
ARG BUILD_FROM
FROM ${BUILD_FROM}

# Устанавливаем wget для скачивания TorrServer
RUN apk add --no-cache wget

# Создаем рабочую директорию
WORKDIR /app

# Скачиваем TorrServer для всех архитектур
ARG TORRSERVER_VERSION="136"
ARG BUILD_ARCH

# Автоматический выбор архитектуры
RUN set -ex \
    && case "${BUILD_ARCH}" in \
        aarch64) TARGET_ARCH="arm64" ;; \
        amd64) TARGET_ARCH="amd64" ;; \
        armhf) TARGET_ARCH="arm" ;; \
        armv7) TARGET_ARCH="arm7" ;; \
        i386) TARGET_ARCH="386" ;; \
        *) echo "ERROR: Unsupported architecture: ${BUILD_ARCH}" && exit 1 ;; \
    esac \
    && echo "Downloading TorrServer for ${TARGET_ARCH}..." \
    && wget -q "https://github.com/YouROK/TorrServer/releases/download/MatriX.${TORRSERVER_VERSION}/TorrServer-linux-${TARGET_ARCH}" \


COPY TorrServer-linux-amd64 /app/TorrServer
RUN chmod +x /app/TorrServer

# S6 will automatically run /etc/services.d/torrserver/run
COPY run.sh /etc/services.d/torrserver/run
RUN chmod +x /etc/services.d/torrserver/run
