FROM node:22-bookworm

LABEL org.opencontainers.image.source="https://github.com/Lyten02/clarmanage-cloud-runtime"

RUN apt-get update \
    && apt-get install -y --no-install-recommends git gh jq ca-certificates \
    && rm -rf /var/lib/apt/lists/* \
    && npm install --global --include=optional \
      @armanage/clarmanage@0.1.50 \
      @openai/codex@0.156.1

COPY health-server.mjs /opt/health-server.mjs
COPY verify-codex-binary.mjs /opt/verify-codex-binary.mjs

RUN node /opt/verify-codex-binary.mjs

WORKDIR /home/workspace

EXPOSE 80

CMD ["node", "/opt/health-server.mjs"]
