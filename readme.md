# Benchmark: building clang for linux

We're building llvm/clang 15.0.1 on ubuntu:22.04.
4220 build steps.

| host/platform/arch     | total time |   x  |                               |
|------------------------|-----------:|-----:|------------------------------:|
| m1/**macos**/aarch64   |   10:48.52 | 0.5x |        native and using clang |
| m1/docker/aarch64	     |   21:22.89 |   1x |         in a VM and using g++ |
| m1/docker+qemu/amd64   | 3:22:42.00 | 9.5x |     in a VM, g++ through qemu |
| m1/colima/aarch64      |   21:01.57 |   1x |                               |
| m1/colima/amd64        |            |      |                               |
| m1/UTM/aarch64         |   20:39.35 |   1x |         in a VM and using g++ |
| m1/UTM+rosetta2/amd64  |   40:23.92 | 1.9x | in a VM, g++ through rosetta2 |
| corei7/**macos**/amd64 |            |      |                               |
| corei7/docker/amd64    | 1:03:59.00 | 2.8x |            in a VM, using g++ |
| corei7/colima/amd64    |            |      |                               |
| corei7/vmware/amd64    |            |      |                               |


- **host m1**: MacBook Pro M1 Max
- **host x86_64**: MacBook Pro 2018 core i7
- **platform macos**: native macos build
- **platform docker**: Docker Desktop for macos
- **platform colima**: Container for LInux for macos
- **platform UTM**: UTM for macos, using Virtualisation Framework with rosetta2
- **platform vmware**: VMWare Fusion


Notes:

macos vs docker native build: macos is twice the speed, but here macos is using
clang and docker is using g++ in a VM.

docker native vs docker emulation: 9.5 time slower, docker desktop is setup
with qemu

rosetta2 in a linux VM: This is 4 to 5 times faster than qemu! The M1 is even
23 minutes faster than the native x86_64 machine !
