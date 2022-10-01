FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update && \
apt-get -y install wget git g++ make python3 time && \
apt-get autoclean && \
apt-get clean && \
apt-get autoremove --purge && \
rm -rf /var/apt/cache/* && \
rm -rf /tmp/*

ARG CMAKE_VERSION=3.24.2

RUN cd /tmp && \
wget https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/cmake-${CMAKE_VERSION}-Linux-$(uname -m).sh && \
sh cmake-${CMAKE_VERSION}-Linux-$(uname -m).sh --skip-license --prefix=/usr/local && \
rm -rf /tmp/cmake-*

ARG NINJA_VERSION=1.11.1

RUN cd /tmp && \
wget https://github.com/ninja-build/ninja/archive/refs/tags/v${NINJA_VERSION}.tar.gz && \
cmake -E tar zxf v${NINJA_VERSION}.tar.gz && \
cd ninja-${NINJA_VERSION} && \
cmake -DCMAKE_BUILD_TYPE=Release . && \
make -j$(nproc) && \
make install && \
rm -rf /tmp/ninja-*

COPY build_clang.sh /.

ENV PS1='[\e[35mubuntu_lts\e[m \W]# '
RUN echo "" >> /root/.bashrc && \
echo "PS1='$PS1'" >> /root/.bashrc
