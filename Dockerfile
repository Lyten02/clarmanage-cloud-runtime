FROM node:22-bookworm

LABEL org.opencontainers.image.source="https://github.com/Lyten02/clarmanage-cloud-runtime"

RUN apt-get update \
    && apt-get install -y --no-install-recommends git gh jq ca-certificates \
    && rm -rf /var/lib/apt/lists/* \
    && npm install --global @armanage/clarmanage@0.1.50

COPY health-server.mjs /opt/health-server.mjs

WORKDIR /home/workspace

EXPOSE 80

CMD ["node", "/opt/health-server.mjs"]
