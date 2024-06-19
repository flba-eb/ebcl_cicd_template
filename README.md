# Example for automatically building for EB corbos Linux (EBcL) and testing on it

## Notes

This is not an official EB product.

## Overview

A container is created which contains a sysroot and image:
- based on the provided EBcL container
- sysroot and OS image are compiled for aarch64

## Usage

1. Build container:

```sh
docker build . -t ebcl_cicd 
```

2. Run container:

Example for `zenoh`:

```sh
docker run -v $(realpath zenoh):/src -it ebcl_cicd  bash 
```

3. Run EBcL image

Run inside the container:

```sh
qemu_efi_aarch64.sh qemu_crinit_aarch64/qemu_crinit_aarch64.aarch64-1.1.0-0.qcow2
```

4. Compile for target, access image

Run inside the container:

- Build a Rust application for image

    Content of `~/.cargo/config.toml`:
    ```toml
    [target.aarch64-unknown-linux-gnu]
    linker = "/usr/bin/aarch64-linux-gnu-gcc-11"
    rustflags = ["-C", "link-args=--sysroot /build/sysroot_aarch64/"]
    ```

    ```sh
    cargo b --target aarch64-unknown-linux-gnu
    ```

- SSH into image:

    ```sh
    ssh -p 2222 root@localhost # password: "linux"
    ```

`sshpass` is installed in the container to automate ssh access without having to type the password.
