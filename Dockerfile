# Sử dụng image Golang để cài đặt aidoku-cli
FROM golang:1.20 as golang_builder

# Cài đặt các công cụ cần thiết
RUN apt-get update && apt-get install -y \
    curl \
    zip \
    unzip \
    git

# Thiết lập biến môi trường GOPATH và PATH cho Go
ENV GOPATH=/go
ENV PATH=$GOPATH/bin:$PATH

# Cài đặt aidoku-cli bằng Go
RUN go install github.com/Aidoku/aidoku-cli/...@latest

# Base image with Rust installed
FROM jdrouet/rust-nightly:buster-slim

# Cài đặt các công cụ cần thiết cho Rust
RUN apt-get update && apt-get install -y \
    curl \
    zip \
    unzip \
    git \
    build-essential

# Sao chép mã nguồn vào container
WORKDIR /workspace
COPY ./src /workspace/src

# Thiết lập môi trường Rust
ENV CARGO_HOME=/usr/local/cargo
ENV PATH=$CARGO_HOME/bin:$PATH

# Định nghĩa entrypoint của container
ENTRYPOINT ["/bin/bash"]