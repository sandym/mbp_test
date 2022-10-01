# Benchmark: building clang for linux

We're building llvm/clang 15.0.1 on ubuntu:22.04.
4220 build steps.

| host/platform/arch    |      time      |
|-----------------------|----------------|
| m1/docker/aarch64	    |    21:22.89    |
| m1/docker+qemu/amd64  |    x           |
| m1/colima/aarch64     |                |
| m1/UTM/aarch64        |    x           |
| m1/UTM+rosetta2/amd64 |    x           |
| x86_64/docker/amd64   |                |
| x86_64/colima/amd64   |                |
| x86_64/vmware/amd64   |                |


- **host m1**: MacBook Pro M1 Max
- **host x86_64**: MacBook Pro 2018 core i7
- **platform docker**: Docker Desktop for macos
- **platform colima**: COntainer for LInux for MAcos
- **platform UTM**: UTM for macos, using Virtualisation Framework with rosetta2
- **platform vmware**: VMWare Fusion
