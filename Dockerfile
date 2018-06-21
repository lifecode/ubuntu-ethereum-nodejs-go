FROM ubuntu:16.04
LABEL maintainer="louis.bao@icloud.com"

# install build deps
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y
RUN apt-get install -y \
      software-properties-common \
      build-essential \
      unzip \
      wget \
      curl \
      jq \
      iputils-ping \
      git \
      make \
      gcc \
      libsodium-dev \
      libdb-dev \
      libleveldb-dev \
      zlib1g-dev \
      libtinfo-dev \
      sysvbanner \
      wrk \
      psmisc

RUN add-apt-repository ppa:ethereum/ethereum && \
    apt-get update && apt-get install -y solc

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash \
    && apt-get install -y nodejs

RUN curl -O https://storage.googleapis.com/golang/go1.10.2.linux-amd64.tar.gz \
    && tar -xvf go1.10.2.linux-amd64.tar.gz \
    && rm go1.10.2.linux-amd64.tar.gz \
    && mv go /usr/local \
    && mkdir -p /go/src /go/bin /go/include /go/pkg

ENV GOROOT /usr/local/go
ENV GOPATH /go
ENV PATH $GOPATH/bin:$GOROOT/bin:$PATH

WORKDIR $GOPATH

RUN go get -u github.com/golang/dep/cmd/dep \
    && go get -u github.com/golang/protobuf/protoc-gen-go \
    && go get -u google.golang.org/genproto/googleapis/api/annotations \
    && go get -u github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway

RUN curl -OL https://github.com/google/protobuf/releases/download/v3.5.1/protoc-3.5.1-linux-x86_64.zip \
    && unzip protoc-3.5.1-linux-x86_64.zip -d protoc3 \
    && mv protoc3/bin/* $GOPATH/bin/ \
    && mv protoc3/include/google $GOPATH/include/ \
    && rm -r protoc3 \
    && rm protoc-3.5.1-linux-x86_64.zip
