# Example for automatically building for EB corbos Linux (EBcL) and testing on it
[![Main Branch CI example](https://github.com/flba-eb/ebcl_cicd_template/actions/workflows/main-ci.yml/badge.svg)](https://github.com/flba-eb/ebcl_cicd_template/actions/workflows/main-ci.yml)

## Notes

This is not an official EB product/project.

## Overview

A container is created which contains a sysroot and image:
- based on the provided EBcL container
- sysroot and OS image are compiled for aarch64

## Usage

- Build container: Run workflow [Build EBcL container with aarch64 sysroot and image](.github/workflows/build-container.yml)
- Run (Zenoh) tests: Run workflow [Main Branch CI](.github/workflows/main-ci.yml)

    - Previously generated container is used
    - It compiles for the target and runs tests on them
    - Target is a QEMU image, simulating an aarch64 CPU
    - Tests are executed on target using the script [run_on_target.sh](scripts/run_on_target.sh), which
        uploads the file and runs it.
    - The zenoh build configuration is slightly changed to reduce disk space usage (especially debug symbols are disabled, see [patch](./zenoh-patch.diff) for details)
