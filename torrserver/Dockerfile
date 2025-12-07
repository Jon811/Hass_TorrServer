# FROM debian:stable-slim
# WORKDIR /app

# # Копируем TorrServer бинарник
# COPY TorrServer-linux-amd64 /app/TorrServer
# RUN chmod +x /app/TorrServer

# # Копируем скрипт запуска
# COPY run.sh /
# RUN chmod +x /run.sh

# # Используем скрипт вместо прямого CMD
# CMD ["/run.sh"]


FROM debian:stable-slim
WORKDIR /app

COPY TorrServer-linux-amd64 /app/TorrServer
RUN chmod +x /app/TorrServer

# Проверяем параметры
RUN echo "=== TorrServer Help ===" && \
    /app/TorrServer --help || true && \
    echo "=== TorrServer Version ===" && \
    /app/TorrServer --version || true

COPY run.sh /
RUN chmod +x /run.sh

CMD ["/run.sh"]