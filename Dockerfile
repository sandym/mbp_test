# syntax=docker/dockerfile:1
FROM ubuntu:23.10

ARG DEBIAN_FRONTEND=noninteractive

RUN <<EOT
apt-get -y update
apt-get -y install wget git g++ make python3 time
apt-get autoclean
apt-get clean
apt-get autoremove --purge
EOT

ARG CMAKE_VERSION=3.27.7

WORKDIR /tmp

RUN <<EOT
wget https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/cmake-${CMAKE_VERSION}-Linux-$(uname -m).sh
sh cmake-${CMAKE_VERSION}-Linux-$(uname -m).sh --skip-license --prefix=/usr/local
rm -rf /tmp/cmake-*
EOT

ARG NINJA_VERSION=1.11.1

RUN <<EOT
wget https://github.com/ninja-build/ninja/archive/refs/tags/v${NINJA_VERSION}.tar.gz
cmake -E tar zxf v${NINJA_VERSION}.tar.gz
cd ninja-${NINJA_VERSION}
cmake -DCMAKE_BUILD_TYPE=Release .
make
make install
rm -rf /tmp/ninja-*
EOT

COPY build_clang.sh /.

WORKDIR /

ENV PS1='[\e[35mubuntu\e[m \W]# '
RUN <<EOT
echo "" >> /root/.bashrc
echo "PS1='$PS1'" >> /root/.bashrc
EOT
