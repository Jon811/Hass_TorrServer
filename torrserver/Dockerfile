ARG BUILD_FROM
FROM $BUILD_FROM

RUN apk add --no-cache wget ca-certificates tzdata \
    && rm -rf /var/cache/apk/*

WORKDIR /app

ARG TORRSERVER_VERSION="136"
ARG BUILD_ARCH

RUN case "${BUILD_ARCH}" in \
    "aarch64") ARCH="arm64" ;; \
    "amd64") ARCH="amd64" ;; \
    "armhf") ARCH="arm" ;; \
    "armv7") ARCH="arm7" ;; \
    "i386") ARCH="386" ;; \
    *) exit 1 ;; \
    esac \
    && wget -q "https://github.com/YouROK/TorrServer/releases/download/MatriX.${TORRSERVER_VERSION}/TorrServer-linux-${ARCH}" -O TorrServer \
    && chmod +x TorrServer

COPY run.sh /
RUN chmod +x /run.sh

# Создаем директорию для данных
RUN mkdir -p /data/torrserver && chmod 777 /data/torrserver

CMD ["/run.sh"]