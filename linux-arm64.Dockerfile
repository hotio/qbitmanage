ARG UPSTREAM_IMAGE
ARG UPSTREAM_DIGEST_ARM64

FROM ${UPSTREAM_IMAGE}@${UPSTREAM_DIGEST_ARM64}

VOLUME ["${CONFIG_DIR}"]

ARG VERSION
RUN curl -fsSL "https://github.com/StuffAnThings/qbit_manage/archive/v${VERSION}.tar.gz" | tar xzf - -C "${APP_DIR}" --strip-components=1 && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

RUN apk add --no-cache py3-pip && \
    apk add --no-cache --virtual=build-dependencies build-base python3-dev && \
    pip3 install --no-cache-dir --upgrade --requirement "${APP_DIR}/requirements.txt" && \
    apk del --purge build-dependencies

COPY root/ /
RUN chmod -R +x /etc/cont-init.d/ /etc/services.d/
