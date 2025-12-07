FROM debian:stable-slim
WORKDIR /app

# Копируем TorrServer бинарник
COPY TorrServer-linux-amd64 /app/TorrServer
RUN chmod +x /app/TorrServer

# Копируем скрипт запуска
COPY run.sh /
RUN chmod +x /run.sh

# Используем скрипт вместо прямого CMD
CMD ["/run.sh"]