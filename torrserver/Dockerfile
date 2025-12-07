ARG BUILD_FROM
FROM ${BUILD_FROM}

WORKDIR /app

# Скачиваем TorrServer (только для amd64 для примера)
RUN wget -q https://github.com/YouROK/TorrServer/releases/download/MatriX.136/TorrServer-linux-amd64 \
    && mv TorrServer-linux-amd64 TorrServer \
    && chmod +x TorrServer

# Копируем скрипт запуска
COPY run.sh /
RUN chmod +x /run.sh