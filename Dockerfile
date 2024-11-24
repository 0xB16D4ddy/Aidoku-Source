# Sử dụng hình ảnh Rust chính thức với phiên bản nightly
FROM rustlang/rust:nightly-slim

# Cài đặt công cụ bổ trợ
RUN apt-get update && apt-get install -y zip && apt-get clean

RUN mkdir -p /app


COPY . /app/

# Thiết lập thư mục làm việc trong container
WORKDIR /app

# Cài đặt target cần thiết
RUN rustup target add wasm32-unknown-unknown

# Update cargo
# RUN cargo update

# Đặt shell làm entrypoint để cho phép tương tác
ENTRYPOINT ["/bin/bash"]
