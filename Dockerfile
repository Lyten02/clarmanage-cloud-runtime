FROM node:22-bookworm

LABEL org.opencontainers.image.source="https://github.com/Lyten02/clarmanage-cloud-runtime"

RUN apt-get update \
    && apt-get install -y --no-install-recommends git gh jq ca-certificates \
    && rm -rf /var/lib/apt/lists/* \
    && npm install --global --include=optional \
      @armanage/clarmanage@0.1.50 \
      @openai/codex@0.156.1 \
    && mkdir -p /opt/clarmanage/bin \
    && ln -s /usr/local/bin/clarmanage /opt/clarmanage/bin/clarmanage \
    && test -x /opt/clarmanage/bin/clarmanage

COPY health-server.mjs /opt/health-server.mjs
COPY verify-codex-binary.mjs /opt/verify-codex-binary.mjs

RUN node /opt/verify-codex-binary.mjs

ENV CODEX_HOME=/home/workspace/.codex \
    GH_CONFIG_DIR=/home/workspace/.config/gh \
    GIT_CONFIG_GLOBAL=/home/workspace/.gitconfig

WORKDIR /home/workspace

EXPOSE 80

CMD ["node", "/opt/health-server.mjs"]
