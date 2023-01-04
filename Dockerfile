# Docker file for tuic server
# ricky9w <ricky9w@donnadie.top>
# Refer:
# https://github.com/EAimTY/tuic

FROM --platform=$TARGETPLATFORM alpine:latest

ARG TARGETPLATFORM
ARG VERSION

ENV SAVE_PATH=/usr/bin/tuic-server

RUN if [ "${TARGETPLATFORM}" = "linux/386" ]; then export TARGET=i686-linux-musl ; fi \
    && if [ "${TARGETPLATFORM}" = "linux/amd64" ]; then export TARGET=x86_64-linux-musl ; fi  \
    && if [ "${TARGETPLATFORM}" = "linux/arm/v7" ]; then export TARGET=armv7-linux-musleabihf ; fi  \
    && if [ "${TARGETPLATFORM}" = "linux/arm64" ]; then export TARGET=aarch64-linux-musl ; fi  \
    && wget -O $SAVE_PATH https://github.com/EAimTY/tuic/releases/download/${VERSION}/tuic-server-${VERSION}-${TARGET} \
    && chmod +x $SAVE_PATH

COPY config.json /etc/tuic/

ENTRYPOINT [ "/usr/bin/tuic-server" ]
CMD [ "-c", "/etc/tuic/config.json" ]
