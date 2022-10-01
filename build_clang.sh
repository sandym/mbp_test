#!/bin/sh

INSTALL_DIR=/work/llvm
BUILD_DIR=/work/llvm_build
TAG=llvmorg-15.0.1

mkdir -p ${BUILD_DIR}

echo "Building in ${BUILD_DIR}"
echo "Installing in ${INSTALL_DIR}"

cd ${BUILD_DIR} || exit -1
if [ ! -d src ]
then
	echo "--> cloning source code..."
	git clone https://github.com/llvm/llvm-project.git src
fi

echo "--> updating source code..."

cd src
git fetch
git checkout tags/${TAG}

cd ${BUILD_DIR} || exit -1

rm -rf build
mkdir -p build
cd build || exit -1
LLVM_ENABLE_PROJECTS="clang;clang-tools-extra;lld"
echo "--> llvm projects:"
echo "       ${LLVM_ENABLE_PROJECTS}"

echo "--> building..."
cmake -G Ninja \
	-Wno-dev \
	-DCMAKE_BUILD_TYPE=Release \
	-DLLVM_ENABLE_LIBXML2=0 \
	-DLLVM_TARGETS_TO_BUILD=host \
	-DLLVM_ENABLE_PROJECTS=${LLVM_ENABLE_PROJECTS} \
	-DCMAKE_INSTALL_PREFIX:PATH="${INSTALL_DIR}" \
	${DEFAULT_SYSROOT} \
	../src/llvm || exit -1
time ninja || exit -1

# echo "--> installing..."
# rm -rf ${INSTALL_DIR} 
# ninja install
# cd "${INSTALL_DIR}"/bin
# # ln -s clang++ c++
# # ln -s clang cc

# echo "--> done"
