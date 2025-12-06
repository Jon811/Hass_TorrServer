# TorrServer Add-on for Home Assistant OS

This repository contains a custom Home Assistant add-on for TorrServer (amd64).

## How to use

1. Create a GitHub repository (for example `https://github.com/yourname/torrserver-hass`) and push the contents of this repo.
2. In Home Assistant: *Settings → Add-ons → Add-on Store → Repositories* — add your repo URL:
   `https://github.com/yourname/torrserver-hass`
3. Install the TorrServer add-on from your repository, start it, and open `http://<HA_IP>:8090`.

## Notes

- Dockerfile uses Debian slim base for glibc compatibility.
- If GitHub rate-limits or redirects cause issues during Docker build on the HA build environment, consider including the binary in the repo or pinning to a specific release asset URL.
- You can pass additional command-line args via the `args` option in add-on configuration.

