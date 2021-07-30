#!/bin/bash

#SO=~/llvm-pass-skeleton/build/skeleton/libSkeletonPass.so
#INSTRUMENT="-Xclang -load -Xclang $SO -lbcs -lrt"

function build(){
  cd $(dirname $1)
  echo ============================
  echo entering path: $(dirname $1)
  make clean
  CC="$CLANG $INSTRUMENT" LD=$CLANG STRIP=$TARGET-strip AR=$CLANG TARGET=$TARGET- make > /dev/null
  if [ $? -eq 0 ]; then
    echo [success] $(dirname $1)
  else
    echo [failed] $(dirname $1)
  fi
}

build $MIBENCH/automotive/basicmath/Makefile
build $MIBENCH/automotive/bitcount/Makefile
build $MIBENCH/automotive/qsort/Makefile
build $MIBENCH/automotive/susan/Makefile
build $MIBENCH/consumer/jpeg/jpeg-6a/configure
build $MIBENCH/consumer/jpeg/jpeg-6a/Makefile
build $MIBENCH/consumer/lame/lame3.70/Makefile
build $MIBENCH/consumer/mad/mad-0.14.2b/configure
build $MIBENCH/consumer/mad/mad-0.14.2b/Makefile
build $MIBENCH/consumer/tiff-v3.5.4/configure
build $MIBENCH/consumer/tiff-v3.5.4/libtiff/Makefile
build $MIBENCH/consumer/tiff-v3.5.4/Makefile
build $MIBENCH/consumer/tiff-v3.5.4/man/Makefile
build $MIBENCH/consumer/tiff-v3.5.4/tools/Makefile
build $MIBENCH/consumer/typeset/lout-3.24/Makefile
build $MIBENCH/network/dijkstra/Makefile
build $MIBENCH/network/patricia/Makefile
build $MIBENCH/office/ghostscript/src/Makefile
build $MIBENCH/office/ispell/languages/Makefile
build $MIBENCH/office/ispell/Makefile
build $MIBENCH/office/rsynth/config
build $MIBENCH/office/rsynth/configure
build $MIBENCH/office/sphinx/configure
build $MIBENCH/office/stringsearch/Makefile
build $MIBENCH/security/blowfish/Makefile
build $MIBENCH/security/pgp/src/Makefile
build $MIBENCH/security/rijndael/Makefile
build $MIBENCH/security/sha/Makefile
build $MIBENCH/telecomm/adpcm/src/Makefile
build $MIBENCH/telecomm/CRC32/Makefile
build $MIBENCH/telecomm/FFT/Makefile
build $MIBENCH/telecomm/gsm/Makefile
