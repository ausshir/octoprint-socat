# see hooks/build and hooks/.config
ARG BASE_IMAGE_PREFIX
FROM ${BASE_IMAGE_PREFIX}alpine

# see hooks/post_checkout
ARG ARCH
COPY qemu-${ARCH}-static /usr/bin

FROM "nunofgs/octoprint:alpine"
LABEL maintainer="Austin Shirley"

RUN mkdir /runwatch
COPY runwatch/run.sh /runwatch/run.sh

# Monitor HomeAssistant
COPY runwatch/200.octoprint.enabled.sh /runwatch/200.octoprint.enabled.sh

# Install socat and bash (bash not included in original octoprint image)
RUN apk add --no-cache socat bash

# Monitor socat
COPY runwatch/100.socat-printer.enabled.sh /runwatch/100.socat-printer.enabled.sh

CMD [ "bash","/runwatch/run.sh" ]
