FROM linux.elektrobit.com/ebcl/sdk:1.1.1_preview_2

# sshpass is required to access the OS (image running in QEMU) without typing the password manually
RUN apt-get update && apt-get install -y \
    sshpass \
    && rm -rf /var/lib/apt/lists/*

USER ebcl

RUN \
    cd /build && \
    git clone https://github.com/Elektrobit/ebcl_template.git -b preview workspace

#RUN bash -ec "source /build/scripts/env.sh && cross_build_image.sh /build/workspace/images/qemu-crinit-aarch64/appliance.kiwi"
#RUN bash -ec "source /build/scripts/env.sh && cross_build_sysroot.sh /build/workspace/images/qemu-crinit-aarch64/appliance_sysroot.kiwi"

# This installs Rust version 1.72.0 as required by zenoh
#RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --default-toolchain 1.72.0 -y && \
#    . "$HOME/.cargo/env" && rustup target add aarch64-unknown-linux-gnu
