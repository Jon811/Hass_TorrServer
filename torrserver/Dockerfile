FROM debian:stable-slim
WORKDIR /app

COPY TorrServer-linux-amd64 /app/TorrServer
RUN chmod +x /app/TorrServer

CMD ["/app/TorrServer", "--port", "8090"]
