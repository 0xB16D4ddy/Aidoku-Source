#!/bin/bash

# Cài đặt toolchain nightly nếu chưa cài
rustup toolchain install nightly



rustup target add wasm32-unknown-unknown --toolchain nightly

# Build release cho target wasm32-unknown-unknown
cargo +nightly build --release --target wasm32-unknown-unknown

# Kiểm tra xem build có tạo ra file .wasm không
if [ ! -f target/wasm32-unknown-unknown/release/*.wasm ]; then
    echo "Error: .wasm file not found!"
    exit 1
fi

# Tạo thư mục Payload và sao chép các file cần thiết
mkdir -p target/wasm32-unknown-unknown/release/Payload
cp res/* target/wasm32-unknown-unknown/release/Payload
cp target/wasm32-unknown-unknown/release/*.wasm target/wasm32-unknown-unknown/release/Payload/main.wasm

# Đóng gói thành file .aix
cd target/wasm32-unknown-unknown/release
zip -r package.aix Payload

mkdir workspace/src/rust/vi.hentaivn/build

# Di chuyển file .aix đến thư mục build trên máy host
mv package.aix ../../../build/package.aix

echo "Build complete and package.aix has been created."
