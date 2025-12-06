FROM alpine:3.18
WORKDIR /app
ADD https://github.com/YouROK/TorrServer/releases/latest/download/TorrServer-linux-amd64 /app/TorrServer
RUN chmod +x /app/TorrServer
CMD ["/app/TorrServer", "--port", "8090"]
