#!/bin/bash -e

mkdir -p ~/.ssh

if [ ! -f ~/.ssh/id_ed25519 ] ; then
    ssh-keygen -q -t ed25519 -N '' -f ~/.ssh/id_ed25519 <<<y >/dev/null 2>&1
fi

# Configure ssh for easier target access
echo '
Host target
    HostName localhost
    Port 2222
    User root
    StrictHostKeyChecking no
' >> ~/.ssh/config

# Configure linker for target and runner for automatic tests
echo '
[target.aarch64-unknown-linux-gnu]
linker = "/usr/bin/aarch64-linux-gnu-gcc-11"
rustflags = ["-C", "link-args=--sysroot /build/sysroot_aarch64/"]
runner = "/scripts/run_on_target.sh"
' >> ~/.cargo/config.toml
