#!/bin/bash -ex

# Run QEMU emulator without any display (it blocks otherwise)
cp "$(which qemu_efi_aarch64.sh)" ./qemu_efi_aarch64_nodisplay.sh
sed 's/-nographic/-display none/' -i qemu_efi_aarch64_nodisplay.sh
./qemu_efi_aarch64_nodisplay.sh /build/result_image/qemu_crinit_aarch64/qemu_crinit_aarch64.aarch64-1.1.0-0.qcow2 &

# Wait a short time for Linux to boot up
sleep 10

# Setup passwordless ssh login
sshpass -p linux ssh target "chown root /root && mkdir /root/.ssh && echo $(cat ~/.ssh/id_ed25519.pub) >> /root/.ssh/authorized_keys"

cd /src

# initial setup for tests; config file is expected two levels above $pwd (this is why we have `a/b/` as subdirs)
ssh target "mkdir -p /tmp/test/a/b"
scp DEFAULT_CONFIG.json5 target:/tmp/test

# Run tests
if [[ "$*" == *"--only-one-test"* ]] ; then
    # only run one small test, as we would run out of disk space otherwise (on standard Github action runners)
    cd commons/zenoh-buffers
fi
df -h .
cargo t --target aarch64-unknown-linux-gnu --release
