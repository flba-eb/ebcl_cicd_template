# Example for automatically building for EB corbos Linux (EBcL) and testing on it

## Notes

This is not an official EB product/project.

## Overview

A container is created which contains a sysroot and image:
- based on the provided EBcL container
- sysroot and OS image are compiled for aarch64

## Usage

Build container: Run workflow `Build EBcL container with aarch64 sysroot and image`
Run (Zenoh) tests: Run workflo `Main Branch CI`

- Previously generated container is used
- It compiles for the target and runs tests on them
- Target is a QEMU image, simulating an aarch64 CPU
- Tests are executed on target using the script `scripts/run_on_targetr.sh`, which
    uploads the file and runs it.
