FROM cr.hotio.dev/hotio/base@sha256:f16b2df0fbefceb0978488fb4a17221819668504b8fd47b675b65e50b074c1c4

ARG VERSION
RUN curl -fsSL "https://github.com/StuffAnThings/qbit_manage/archive/${VERSION}.tar.gz" | tar xzf - -C "${APP_DIR}" --strip-components=1 && \
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
RUN chmod -R +x /etc/cont-init.d/ /etc/services.d/
