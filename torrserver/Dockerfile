FROM debian:stable-slim
LABEL maintainer="yourname"

WORKDIR /app

# Install runtime deps
RUN apt-get update \
    && apt-get install -y --no-install-recommends wget ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Download TorrServer binary (amd64)
RUN wget -O /app/TorrServer \
    https://github.com/YouROK/TorrServer/releases/latest/download/TorrServer-linux-amd64 \
    && chmod +x /app/TorrServer

# Create a non-root user (optional but recommended for addons)
RUN useradd -m -s /bin/bash torr && chown -R torr:torr /app

USER torr
EXPOSE 8090

CMD ["/app/TorrServer", "--port", "8090"]
