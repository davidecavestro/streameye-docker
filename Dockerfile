ARG ALPINE_VERSION=latest
FROM alpine:${ALPINE_VERSION} AS builder
ARG STREAMEYE_TAG=master

RUN apk update && apk add git make gcc libc-dev ffmpeg
RUN git clone --depth=1 --branch=${STREAMEYE_TAG} https://github.com/ccrisan/streameye.git /tmp/app && \
  cd /tmp/app  && \
  make && \
  make install

FROM alpine:${ALPINE_VERSION}
COPY --from=builder /usr/local/bin/streameye /usr/local/bin/streameye

ENTRYPOINT ["/usr/local/bin/streameye"]

