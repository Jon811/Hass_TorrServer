ARG BUILD_FROM
FROM ${BUILD_FROM}

RUN apk add --no-cache wget

WORKDIR /app

RUN wget -q https://github.com/YouROK/TorrServer/releases/download/MatriX.136/TorrServer-linux-amd64 \
    && mv TorrServer-linux-amd64 TorrServer \
    && chmod +x TorrServer

COPY run.sh /
RUN chmod +x /run.sh