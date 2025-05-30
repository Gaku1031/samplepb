FROM golang:1.23-alpine

# Install necessary system dependencies
RUN apk update && apk add --no-cache \
    git \
    curl \
    alpine-sdk \
    bash \
    protobuf-dev

# Set Go environment variables
ENV GO111MODULE=on \
    GOPATH=/go \
    PATH=$GOPATH/bin:/usr/local/go/bin:$PATH

# Install protoc plugins for Go
RUN go install google.golang.org/protobuf/cmd/protoc-gen-go@v1.34.0 \
    && go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@v1.3.0

# Prepare working directory
RUN mkdir -p /go/src/samplepb
WORKDIR /go/src/samplepb
ADD . /go/src/samplepb
