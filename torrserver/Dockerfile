ARG BUILD_FROM
FROM ${BUILD_FROM}

# Скачиваем TorrServer
WORKDIR /app

ARG TORRSERVER_VERSION="136"
ARG BUILD_ARCH

RUN set -x \
    && ARCH="${BUILD_ARCH}" \
    && case "${ARCH}" in \
        aarch64) ARCH="arm64" ;; \
        amd64)   ARCH="amd64" ;; \
        armhf)   ARCH="arm" ;; \
        armv7)   ARCH="arm7" ;; \
        i386)    ARCH="386" ;; \
        *) echo "Unsupported: ${ARCH}"; exit 1 ;; \
    esac \
    && wget -q "https://github.com/YouROK/TorrServer/releases/download/MatriX.${TORRSERVER_VERSION}/TorrServer-linux-${ARCH}" \
    && mv "TorrServer-linux-${ARCH}" TorrServer \
    && chmod +x TorrServer

# Просто копируем скрипт
COPY run.sh /run.sh
RUN chmod +x /run.sh

# Никакого CMD или ENTRYPOINT!