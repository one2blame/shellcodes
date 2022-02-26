#!/bin/bash
set -ex -o pipefail
declare -a archs=("arm" "i686" "mips" "powerpc" "x86_64")


check_deps () {
    arm_linux_gnueabi_gcc=`which arm-linux-gnueabi-gcc`
    i686_linux_gnu_gcc=`which i686-linux-gnu-gcc`
    mips_linux_gnu_gcc=`which mips-linux-gnu-gcc`
    powerpc_linux_gnu_gcc=`which powerpc-linux-gnu-gcc`
    x86_64_linux_gnu_gcc=`which x86_64-linux-gnu-gcc`
    arm_linux_gnueabi_objcopy=`which arm-linux-gnueabi-objcopy`
    i686_linux_gnu_objcopy=`which i686-linux-gnu-objcopy`
    mips_linux_gnu_objcopy=`which mips-linux-gnu-objcopy`
    powerpc_linux_gnu_objcopy=`which powerpc-linux-gnu-objcopy`
    x86_64_linux_gnu_objcopy=`which x86_64-linux-gnu-objcopy`
    make=`which make`
}


clean () {
    for arch in "${archs[@]}"
    do
        make clean -C src arch=$arch
        make clean -C test arch=$arch
    done
}


build () {
    for arch in "${archs[@]}"
    do
        make -C src arch=$arch
        make -C test arch=$arch
    done
}


check_deps
clean
build
