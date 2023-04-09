FROM golang:1.20.2-alpine

RUN apk update && \
  apk upgrade && \
  apk add --no-cache \
  bash \
  ca-certificates \
  git \
  gcc \
  musl-dev \
  g++ \
  git \
  libc-dev \
  openssh && \
  apk add --update \
  gcc \
  git \
  openssh \
  openssl \
  tzdata

ENV GOPATH=/go \
  PATH=$PATH:$GOPATH/bin \
  GOPRIVATE=github.com/reynandaptr/*

RUN mkdir -p /go/src && \
  mkdir -p /go/bin && \
  mkdir -p /go/pkg

COPY .gitconfig .gitconfig

RUN mkdir ~/.ssh && \
  ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts && \
  mv .gitconfig ~/.gitconfig

CMD [ "echo", "go-builder" ]
