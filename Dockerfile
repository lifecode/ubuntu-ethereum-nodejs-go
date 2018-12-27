FROM louisbb/ubuntu-ethereum:v1.0.0
LABEL maintainer="louis.bao@icloud.com"

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash \
    && apt-get install -y nodejs \
    && npm install --global yarn

RUN curl -O https://storage.googleapis.com/golang/go1.10.2.linux-amd64.tar.gz \
    && tar -xvf go1.10.2.linux-amd64.tar.gz \
    && rm go1.10.2.linux-amd64.tar.gz \
    && mv go /usr/local \
    && mkdir -p /go/src /go/bin /go/include /go/pkg

ENV GOROOT /usr/local/go
ENV GOPATH /go
ENV PATH $GOPATH/bin:$GOROOT/bin:$PATH

WORKDIR $GOPATH

RUN curl -OL https://github.com/google/protobuf/releases/download/v3.5.1/protoc-3.5.1-linux-x86_64.zip \
    && unzip protoc-3.5.1-linux-x86_64.zip -d protoc3 \
    && mv protoc3/bin/* $GOPATH/bin/ \
    && mv protoc3/include/google $GOPATH/include/ \
    && rm -r protoc3 \
    && rm protoc-3.5.1-linux-x86_64.zip

RUN go get -u github.com/ethereum/go-ethereum

RUN go get -u github.com/golang/dep/cmd/dep \
    && go get -u golang.org/x/crypto/ssh/terminal \
    && go get -u github.com/golang/glog \
    && go get -u github.com/ghodss/yaml \
    && go get -u golang.org/x/sys/unix
