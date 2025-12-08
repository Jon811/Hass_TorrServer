# torrserver/Dockerfile - УНИВЕРСАЛЬНЫЙ для всех архитектур
ARG BUILD_FROM="ghcr.io/home-assistant/amd64-base:latest"
FROM ${BUILD_FROM}

# Устанавливаем wget для скачивания
RUN apk add --no-cache \
    wget \
    ca-certificates \
    && rm -rf /var/cache/apk/*

WORKDIR /app

# Аргументы сборки (заполняются из build.json)
ARG TORRSERVER_VERSION="136"
ARG BUILD_ARCH

# Определяем архитектуру для скачивания правильного бинарника
RUN echo "Building for architecture: ${BUILD_ARCH}" && \
    case "${BUILD_ARCH}" in \
        "aarch64") \
            TARGET_ARCH="arm64" \
            && echo "Downloading TorrServer for ARM64 (Raspberry Pi 4, 64-bit ARM)" ;; \
        "amd64") \
            TARGET_ARCH="amd64" \
            && echo "Downloading TorrServer for AMD64 (x86-64 PCs)" ;; \
        "armhf") \
            TARGET_ARCH="arm" \
            && echo "Downloading TorrServer for ARM (32-bit ARM hard float)" ;; \
        "armv7") \
            TARGET_ARCH="arm7" \
            && echo "Downloading TorrServer for ARM7 (32-bit ARM v7)" ;; \
        "i386") \
            TARGET_ARCH="386" \
            && echo "Downloading TorrServer for i386 (32-bit x86)" ;; \
        *) \
            echo "ERROR: Unsupported architecture: ${BUILD_ARCH}" \
            && echo "Supported: aarch64, amd64, armhf, armv7, i386" \
            && exit 1 ;; \
    esac && \
    # Скачиваем TorrServer
    wget -q "https://github.com/YouROK/TorrServer/releases/download/MatriX.${TORRSERVER_VERSION}/TorrServer-linux-${TARGET_ARCH}" \
    && mv "TorrServer-linux-${TARGET_ARCH}" TorrServer \
    && chmod +x TorrServer \
    && echo "TorrServer ${TORRSERVER_VERSION} for ${TARGET_ARCH} downloaded successfully" \
    && ls -la TorrServer

# Простая проверка бинарника (без запуска)
RUN echo "Verifying binary..." && \
    file TorrServer && \
    echo "Binary is ready"

# Копируем скрипт запуска
COPY run.sh /
RUN chmod +x /run.sh

# Не указываем CMD - Home Assistant запускает run.sh напрямую