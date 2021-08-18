#!/bin/bash

function runme(){
  git restore $1

  echo "#=============================="
  echo cd $(dirname $1)
  echo [ SHELL ] $(realpath --relative-to=$MIBENCH $1)
  sed -i 's/^[a-z]/.\/&/g' $1
  cat $1

  cd $(dirname $1)
  file=$(basename $1)

  # comments; inputs; outputs, prefix
  elfs=$(cat $file | sed 's/^#.*//g;s/ < / /g;s/ > .*//g;s/^[a-z]/.\/&/g;' | awk '{ print $1 }' | sort | uniq | xargs)
  args=$(cat $file | sed 's/^#.*//g;s/ < / /g;s/ > .*//g;s/^[a-z]/.\/&/g;' | awk '{ $1=""; print $0 }'| sort | uniq | xargs)
  
  for elf in $elfs; do
    if [ -x $elf ]; then
      riscv=$(riscv64-unknown-linux-gnu-readelf -h $elf | grep Machine | awk '{ print $2 }')
      echo [ $riscv ] $(realpath --relative-to=$MIBENCH $elf)
    fi
  done
  # args
  for arg in $args; do
    if [ -f $arg -a -s $arg ]; then
      echo [ DATA ] $(realpath --relative-to=$MIBENCH $arg)
    elif [ -d $arg ]; then
      echo [ PATH ] $(realpath --relative-to=$MIBENCH $arg)
    else
      echo [ ARGS ] $arg
    fi
  done

  cd $MIBENCH
}

echo $MIBENCH
for file in $(find ./ -name "runme_*.sh"); do
  runme $file
done
