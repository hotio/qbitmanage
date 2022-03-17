FROM cr.hotio.dev/hotio/base@sha256:ab76c33229508fe135b2ef84762fee8c28520d15e5b8ed19da99ac88f34f9dd0

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
