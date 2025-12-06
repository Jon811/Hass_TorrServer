#!/usr/bin/env bash
# Simple wrapper to start TorrServer (keeps compatibility with some add-on expectations)
exec /app/TorrServer --port 8090 "$@"
