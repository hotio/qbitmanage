FROM cr.hotio.dev/hotio/base@sha256:3c39dad385f58b6181e4241ca35f1eaa79adfe4f435e42cba564b6b06dc3e03a

ARG VERSION
RUN curl -fsSL "https://github.com/StuffAnThings/qbit_manage/archive/v${VERSION}.tar.gz" | tar xzf - -C "${APP_DIR}" --strip-components=1 && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

RUN apk add --no-cache py3-pip && \
    apk add --no-cache --virtual=build-dependencies build-base python3-dev && \
    pip3 install --no-cache-dir --upgrade \
        ruamel.yaml \
        qbittorrent-api \
        schedule \
        retrying \
        alive_progress && \
    apk del --purge build-dependencies

COPY root/ /
