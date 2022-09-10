FROM cr.hotio.dev/hotio/base@sha256:0822c919140fe2349963642616f4f5bcc0ffa2624a81d2247c450cd9ed97211e

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
