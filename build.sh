#!/bin/bash

log="$(pwd)/complie.log"
echo "Automatic generated log:" > $log

function compile_target(){
  if [ $# -eq 0 ]; then
    gcc=$gcc make > /dev/null
    if [ $? -eq 0 ]; then
      echo $(pwd): $gcc make >> $log
      return 0
    fi
  else
    gcc=$gcc make $1 > /dev/null
    if [ $? -eq 0 ]; then
      echo $(pwd): $gcc make $1 >> $log
      return 0
    fi
  fi
  return -1
}

function cross_compile(){
  prefixes="riscv64-unknown-linux-gnu riscv64-unknown-elf"
  targets="all patricia sha crc fft"
  for prefix in $prefixes; do
    # setup env
    export gcc=$prefix-gcc
    # for all specific target
    for target in $targets; do
      compile_target $target
      if [ $? -eq 0 ]; then
        return 0
      fi
    done
    # default target
    compile_target
    if [ $? -eq 0 ]; then
      return 0
    fi  
  done
  return -1
}

function dfs(){
  if test -d $1; then
    for path in $(ls $1); do
      if test -f $path; then
        if [ $path = "Makefile" ]; then
          echo ==================Makefile found!=====================
          git restore Makefile
          sed -i 's/strip/riscv64-unknown-linux-gnu-strip/g' Makefile
          make clean
          cross_compile
          if [ $? -eq 0 ]; then
            echo $(pwd): build successfaully!
          else
            echo $(pwd): build failed!
          fi
        elif [ $path = "configure" ]; then
          echo $(pwd): needs configure! >> $log  
        fi
      elif test -d $path; then
        cd $path
        dfs $1/$path
        cd ..
      fi
    done
  fi
}

dfs $(pwd)
