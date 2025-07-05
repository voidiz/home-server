FROM alpine:3.22

RUN apk add --no-cache bash curl jq lftp openssh su-exec

# Latest releases available at https://github.com/aptible/supercronic/releases
ENV SUPERCRONIC_URL=https://github.com/aptible/supercronic/releases/download/v0.2.34/supercronic-linux-arm \
    SUPERCRONIC_SHA1SUM=4ba4cd0da62082056b6def085fa9377d965fbe01 \
    SUPERCRONIC=supercronic-linux-arm

RUN curl -fsSLO "$SUPERCRONIC_URL" \
    && echo "${SUPERCRONIC_SHA1SUM}  ${SUPERCRONIC}" | sha1sum -c - \
    && chmod +x "$SUPERCRONIC" \
    && mv "$SUPERCRONIC" "/usr/local/bin/${SUPERCRONIC}" \
    && ln -s "/usr/local/bin/${SUPERCRONIC}" /usr/local/bin/supercronic

ENTRYPOINT ["bash"]
