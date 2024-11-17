# Sử dụng hình ảnh Rust chính thức với phiên bản nightly
FROM rustlang/rust:nightly-slim

# Cài đặt công cụ bổ trợ
RUN apt-get update && apt-get install -y zip && apt-get clean

# Thiết lập thư mục làm việc trong container
WORKDIR /workspace

# Cài đặt target cần thiết
RUN rustup target add wasm32-unknown-unknown

# Đặt shell làm entrypoint để cho phép tương tác
ENTRYPOINT ["/bin/bash"]
