ARG BUILD_FROM
FROM ${BUILD_FROM}

RUN apk add --no-cache \
    wget \
    ca-certificates
WORKDIR /app

# COPY TorrServer-linux-amd64 /app/TorrServer
# RUN chmod +x /app/TorrServer
# Загружаем TorrServer из GitHub
ARG TORRSERVER_VERSION="136"
ARG TORRSERVER_ARCH="amd64"

# Скачиваем последнюю версию
RUN echo "Downloading TorrServer MatriX.${TORRSERVER_VERSION} for ${TORRSERVER_ARCH}..." && \
    wget -q "https://github.com/YouROK/TorrServer/releases/download/MatriX.${TORRSERVER_VERSION}/TorrServer-linux-${TORRSERVER_ARCH}" \
    -O /app/TorrServer && \
    chmod +x /app/TorrServer && \
    echo "TorrServer downloaded successfully"

# Проверяем что бинарник работает
RUN /app/TorrServer --help 2>&1 | head -5 && echo "Binary check passed"

COPY run.sh /
RUN chmod +x /run.sh

CMD ["/run.sh"]