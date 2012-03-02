#!/bin/bash

export PLATFORM_DIR=~/cm9
rm -R $PLATFORM_DIR/kernel/tegra-temp/*
export KERNEL_BUILD_OUT=$PLATFORM_DIR/kernel/tegra-temp
export ARCH=arm
export CROSS_COMPILE=$PLATFORM_DIR/prebuilt/linux-x86/toolchain/arm-eabi-4.4.3/bin/arm-eabi-
export KERNEL_SRC=$PLATFORM_DIR/kernel/tegra
#KBUILD_BUILD_VERSION=""
#export UTS_MACHINE="arm"
export UTS_VERSION=""
export LINUX_COMPILE_BY="peetr_"
export LINUX_COMPILE_HOST=""
export LINUX_COMPILE_DOMAIN=""
export LINUX_COMPILER=""
export KBUILD_BUILD_VERSION
make distclean
make mrproper
make -j1 -C $KERNEL_SRC O=$KERNEL_BUILD_OUT KBUILD_DEFCONFIG=tegra_sunfire_cyanogenmod_defconfig defconfig modules_prepare
make -j1 -C $KERNEL_SRC O=$KERNEL_BUILD_OUT DEPMOD=out/host/linux-x86/bin/depmod INSTALL_MOD_PATH=$KERNEL_BUILD_OUT modules
make -j1 -C $KERNEL_SRC O=$KERNEL_BUILD_OUT DEPMOD=out/host/linux-x86/bin/depmod INSTALL_MOD_PATH=$KERNEL_BUILD_OUT modules_install
make -j1 -C $KERNEL_SRC O=$KERNEL_BUILD_OUT zImage
make -j1 -C $KERNEL_SRC O=$KERNEL_BUILD_OUT DEPMOD=out/host/linux-x86/bin/depmod INSTALL_MOD_PATH=$KERNEL_BUILD_OUT M=$PLATFORM_DIR/vendor/authentec/safenet/vpndriver modules
export ANDROID_BUILD_TOP=/$PLATFORM_DIR
export LINUXSRCDIR=$KERNEL_SRC
export LINUXBUILDDIR=$PLATFORM_DIR/kernel/tegra-temp
make -C $PLATFORM_DIR/vendor/bcm/wlan/osrc/open-src/src/dhd/linux 
cp $PLATFORM_DIR/kernel/tegra-temp/arch/arm/boot/zImage $PLATFORM_DIR/kernel/compiled/zImage
cp $PLATFORM_DIR/vendor/authentec/safenet/vpndriver/vpnclient.ko $PLATFORM_DIR/kernel/compiled/modules/vpnclient.ko
cp $PLATFORM_DIR/vendor/bcm/wlan/osrc/open-src/src/dhd/linux/dhd.ko $PLATFORM_DIR/kernel/compiled/modules/dhd.ko
