#!/bin/sh

export MIBENCH=/home/ubuntu/mibench

function runme(){
  echo "#=============================="
  echo cd $(dirname $1)
  echo [ SHELL ] $1
  cat $1

  cd $(dirname $1)
  file=$(basename $1)

  time -p ./$(basename $1)

  cd $MIBENCH
}

echo run in $MIBENCH

echo [runme-small.sh]
for file in $(find ./ -name runme_small.sh); do
  runme $file
done

echo [runme-large.sh]
for file in $(find ./ -name runme_large.sh); do
  runme $file
done
