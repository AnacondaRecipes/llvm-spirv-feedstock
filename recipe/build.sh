#!/bin/bash

EXTRA_CMAKE_ARGS=""
if [[ "$target_platform" == "osx-64" ]]; then
  EXTRA_CMAKE_ARGS="${EXTRA_CMAKE_ARGS} -DCMAKE_MACOSX_RPATH=ON -DCMAKE_BUILD_WITH_INSTALL_RPATH=ON"
fi

mkdir build
cd build

cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DLLVM_DIR=$PREFIX/lib/cmake/llvm \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DCMAKE_INSTALL_RPATH=${PREFIX}/lib \
    -DCMAKE_PREFIX_PATH=$PREFIX \
    -DBUILD_SHARED_LIBS=yes \
    ${EXTRA_CMAKE_ARGS} \
    ..

make -j${CPU_COUNT}
make install


make llvm-spirv -j${CPU_COUNT}
cp tools/llvm-spirv/llvm-spirv $PREFIX/bin/llvm-spirv

