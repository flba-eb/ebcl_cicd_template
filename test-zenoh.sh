#!/bin/bash -ex

source /build/scripts/env.sh

echo '
[target.aarch64-unknown-linux-gnu]
linker = "/usr/bin/aarch64-linux-gnu-gcc-11"
rustflags = ["-C", "link-args=--sysroot /build/sysroot_aarch64/"]
' >> ~/.cargo/config.toml

cd /src
cargo b --target aarch64-unknown-linux-gnu
