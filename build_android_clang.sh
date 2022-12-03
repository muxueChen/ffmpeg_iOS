#!/bin/bash
API=29
ARCH=arm64
CPU=armv8-a
TOOL_CPU_NAME=aarch64
NDK=/Users/chenxueming/Library/Android/sdk/ndk/25.1.8937393
TOOLCHAIN=$NDK/toolchains/llvm/prebuilt/darwin-x86_64
SYSROOT=$TOOLCHAIN/sysroot

TOOL_PREFIX="$TOOLCHAIN/bin/$TOOL_CPU_NAME-linux-android"
THIN=`pwd`/"thin/android"

CC="$TOOL_PREFIX$API-clang"
CXX="$TOOL_PREFIX$API-clang++"
function build
{
  ./configure \
  --prefix="$THIN/$ARCH" \
  --target-os=android \
  --arch=$ARCH  \
  --cpu=$CPU \
  --enable-cross-compile \
  --disable-debug \
  --enable-shared \
  --disable-static \
  --disable-doc \
  --disable-ffserver \
  --cc=$CC \
  --cxx=$CXX \
  --sysroot=$SYSROOT \
  --extra-cflags="-Os -fpic -march"
  --extra-ldflags="-march" \
  $ADDITIONAL_CONFIGURE_FLAG
  make clean all
  # 这里是定义用几个CPU编译
  make -j8
  make install
}
build