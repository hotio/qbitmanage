FROM cr.hotio.dev/hotio/base@sha256:66c1cd47c5b50c6e3826ba7b4d0417ec1acd509b74dea2e51befe66ad63bff7d

ARG VERSION
RUN curl -fsSL "https://github.com/StuffAnThings/qbit_manage/archive/${VERSION}.tar.gz" | tar xzf - -C "${APP_DIR}" --strip-components=1 && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

RUN apk add --no-cache py3-pip && \
    pip3 install --no-cache-dir --upgrade \
        ruamel.yaml \
        qbittorrent-api \
        schedule \
        retrying \
        alive_progress

COPY root/ /
