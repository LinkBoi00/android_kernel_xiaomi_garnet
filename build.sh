#!/bin/bash
#
# Copyright (C) 2024 Elias Dimopoulos
# SPDX-License-Identifier: Apache-2.0
#

# Script variables
SCRIPT_DIR=$(pwd)/build
TC_DIR="$SCRIPT_DIR"/clang-r416183b
MAKE_ARGS="O=out ARCH=arm64 CC=clang LLVM=1 LLVM_IAS=1 CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_ARM32=arm-linux-gnueabi-"

# Clone aosp clang from its repo
git clone --depth=1 https://github.com/LineageOS/android_prebuilts_clang_kernel_linux-x86_clang-r416183b $TC_DIR

# Clone AnyKernel3 (TODO: Fix this for GKI and garnet)
git clone --depth=1 -b cannon https://github.com/Couchpotato-sauce/AnyKernel3 $SCRIPT_DIR/AnyKernel3 

# Export the PATH variable
export PATH="$TC_DIR/bin:$PATH"

# Build defconfig
make -j"$(nproc --all)" $MAKE_ARGS garnet_defconfig

# Build kernel
make -j"$(nproc --all)" $MAKE_ARGS
