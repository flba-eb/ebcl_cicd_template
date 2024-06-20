#!/bin/bash -ex

# todo: move to Dockerfile
rustup target add aarch64-unknown-linux-gnu

echo '
[target.aarch64-unknown-linux-gnu]
linker = "/usr/bin/aarch64-linux-gnu-gcc-11"
rustflags = ["-C", "link-args=--sysroot /build/sysroot_aarch64/"]
' >> ~/.cargo/config.toml

cd zenoh
cargo b --target aarch64-unknown-linux-gnu
