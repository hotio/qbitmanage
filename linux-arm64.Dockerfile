ARG UPSTREAM_IMAGE
ARG UPSTREAM_DIGEST_ARM64

FROM ${UPSTREAM_IMAGE}@${UPSTREAM_DIGEST_ARM64}
ARG IMAGE_STATS
ENV IMAGE_STATS=${IMAGE_STATS} QBM_DOCKER=True

ARG VERSION
RUN curl -fsSL "https://github.com/StuffAnThings/qbit_manage/archive/${VERSION}.tar.gz" | tar xzf - -C "${APP_DIR}" --strip-components=1 && \
    rm -rf "${APP_DIR}/config" && \
    ln -sf "${CONFIG_DIR}" "${APP_DIR}/config" && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

RUN apk add --no-cache py3-pip && \
    apk add --no-cache --virtual=build-dependencies build-base python3-dev && \
    pip3 install --break-system-packages --no-cache-dir --upgrade "${APP_DIR}" && \
    apk del --purge build-dependencies

COPY root/ /
