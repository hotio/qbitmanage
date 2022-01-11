FROM cr.hotio.dev/hotio/base@sha256:a5b4a850b6128d497dd55ea28290133352a80b9992a29e0a6e7918b4021d2ab5

RUN apk add --no-cache py3-pip && \
    pip3 install --no-cache-dir --upgrade \
        ruamel.yaml \
        qbittorrent-api=2022.1.27 \
        schedule \
        retrying \
        alive_progress

ARG VERSION
RUN curl -fsSL "https://github.com/StuffAnThings/qbit_manage/archive/${VERSION}.tar.gz" | tar xzf - -C "${APP_DIR}" --strip-components=1 && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /
