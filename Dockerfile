FROM linux.elektrobit.com/ebcl/sdk:1.1.1_preview_4

# sshpass is required to access the OS (image running in QEMU) without typing the password manually
RUN sudo apt-get update && sudo apt-get install -y \
    sshpass \
    && sudo rm -rf /var/lib/apt/lists/*

USER ebcl

RUN \
    cd /build && \
    git clone https://github.com/Elektrobit/ebcl_template.git -b preview workspace

RUN \
    bash -ec "source /build/scripts/env.sh && cross_build_image.sh /build/workspace/images/qemu-crinit-aarch64/appliance.kiwi" && \
    bash -ec "source /build/scripts/env.sh && cross_build_sysroot.sh /build/workspace/images/qemu-crinit-aarch64/appliance_sysroot.kiwi" && \
    du -shc /tmp/build/* /home/ebcl/.kiwi_boxes/* && \
    rm -rf /tmp/build/* /home/ebcl/.kiwi_boxes/*

# This installs the Rust version as required by zenoh
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --default-toolchain 1.75.0 -y && \
   . "$HOME/.cargo/env" && rustup target add aarch64-unknown-linux-gnu
