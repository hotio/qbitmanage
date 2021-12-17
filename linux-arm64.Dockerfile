FROM cr.hotio.dev/hotio/base@sha256:9f4741371043929c19ed6b7468b18aa9e07c66143ffe92bf8c2e2ff78d0193fa

RUN apk add --no-cache py3-setuptools && \
    apk add --no-cache --virtual=build-dependencies py3-pip && \
    pip3 install --no-cache-dir --upgrade \
        ruamel.yaml \
        qbittorrent-api \
        schedule \
        retrying \
        alive_progress

ARG VERSION
RUN curl -fsSL "https://github.com/StuffAnThings/qbit_manage/archive/v${VERSION}.tar.gz" | tar xzf - -C "${APP_DIR}" --strip-components=1 && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /
