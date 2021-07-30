#!/bin/bash

SO=~/llvm-pass-skeleton/build/skeleton/libSkeletonPass.so
INSTRUMENT="-Xclang -load -Xclang $SO -lbcs -lrt"

INSTRUMENT=""
CLANG="clang --gcc-toolchain=$TOOLCHAIN --sysroot=$SYSROOT --target=$TARGET -march=$MARCH $INSTRUMENT"

function prolog(){
  echo ==================== Entering directory: ====================
  cd $1
  echo $(pwd)
}

function epilog(){
  CC=gcc make clean > /dev/null
  CC=gcc make all
  git restore Makefile
  if [ $? -eq 0 ]; then
    echo compile successfully!
  else
    echo compile failed!
  fi
}

prolog $MIBENCH/automotive/basicmath/
sed -i 's/gcc/$(CC)/g' Makefile
sed -i '4i CC ?= gcc' Makefile
epilog $MIBENCH/automotive/basicmath/
 
prolog $MIBENCH/automotive/bitcount/
sed -i 's/bitcnts:/all:/g' Makefile
sed -i 's/gcc/$(CC)/g' Makefile
sed -i '3i CC ?= gcc' Makefile
epilog $MIBENCH/automotive/bitcount/

prolog $MIBENCH/automotive/qsort/
sed -i 's/gcc/$(CC)/g' Makefile
sed -i '3i CC ?= gcc' Makefile
epilog

prolog $MIBENCH/automotive/susan/
sed -i 's/susan:/all:/g' Makefile
sed -i 's/gcc/$(CC)/g' Makefile
sed -i '1i CC ?= gcc' Makefile
epilog

prolog $MIBENCH/consumer/jpeg/jpeg-6a/configure
prolog $MIBENCH/consumer/jpeg/jpeg-6a/
prolog $MIBENCH/consumer/lame/lame3.70/
prolog $MIBENCH/consumer/mad/mad-0.14.2b/configure
prolog $MIBENCH/consumer/mad/mad-0.14.2b/
prolog $MIBENCH/consumer/tiff-v3.5.4/configure
prolog $MIBENCH/consumer/tiff-v3.5.4/libtiff/
prolog $MIBENCH/consumer/tiff-v3.5.4/
prolog $MIBENCH/consumer/tiff-v3.5.4/man/
prolog $MIBENCH/consumer/tiff-v3.5.4/tools/
prolog $MIBENCH/consumer/typeset/lout-3.24/
prolog $MIBENCH/.git/config
prolog $MIBENCH/network/dijkstra/
sed -i '1i CC ?= gcc' Makefile
sed -i 's/gcc/$(CC)/g' Makefile
epilog

prolog $MIBENCH/network/patricia/
sed -i '1i CC ?= gcc' Makefile
sed -i 's/gcc/$(CC)/g' Makefile
sed -i 's/patricia:/all:/g' Makefile
epilog


prolog $MIBENCH/office/ghostscript/src/
prolog $MIBENCH/office/ispell/languages/
prolog $MIBENCH/office/ispell/
prolog $MIBENCH/office/rsynth/config
prolog $MIBENCH/office/rsynth/configure
prolog $MIBENCH/office/sphinx/configure
prolog $MIBENCH/office/stringsearch/
prolog $MIBENCH/security/blowfish/
prolog $MIBENCH/security/pgp/src/

prolog $MIBENCH/security/rijndael/
sed -i '1i CC ?= gcc' Makefile
sed -i 's/gcc/$(CC)/g' Makefile
sed -i 's/rijndael:/all:/g' Makefile
sed -i 's/Makefile//g' Makefile
epilog

prolog $MIBENCH/security/sha/
sed -i 's/sha:/all:/g' Makefile
sed -i "s/strip/$TARGET-strip/g" Makefile
sed -i 's/.o/.c/g' Makefile
sed -i '6c CC ?= gcc' Makefile
epilog

prolog $MIBENCH/telecomm/adpcm/src/
sed -i '14c CC ?= gcc' Makefile
epilog

prolog $MIBENCH/telecomm/CRC32/
sed -i 's/crc:/all:/g' Makefile
sed -i 's/gcc/$(CC)/g' Makefile
sed -i '1i CC ?= gcc' Makefile
epilog

prolog $MIBENCH/telecomm/FFT/
sed -i 's/fft:/all:/g' Makefile
sed -i 's/gcc/$(CC)/g' Makefile
sed -i '3i CC ?= gcc' Makefile
epilog

prolog $MIBENCH/telecomm/gsm/
sed -i '35s/=/?=/g' Makefile
epilog
