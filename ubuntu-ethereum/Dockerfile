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
