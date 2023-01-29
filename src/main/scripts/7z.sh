#!/bin/bash
#!/usr/bin/env bash
function_express() {
    filename=$1
    filename_dir="$filename"".dir"
    cd "$filename_dir" || exit
    find . -type f |awk -F' ' '{print $1}'|head -n 1 |xargs 7z e
    mv "$filename" ../
}
function_compress() {
    filename=$1
    filename_dir="$filename"".dir"
    mkdir -p filename_dir
    7z a -v1M "./""$filename_dir/""$filename"".7z" "./""$filename"
}
PRG="$0"
while [ -h "$PRG" ]; do
  ls=$(ls -ld "$PRG")
  link=$(expr "$ls" : '.*-> \(.*\)$')
  if expr "$link" : '/.*' > /dev/null; then
    PRG="$link"
  else
    PRG=$(dirname "$PRG")/"$link"
  fi
done

PRGDIR=$(dirname "$PRG")
BASEDIR=$(cd "$PRGDIR/.." >/dev/null || exit; pwd)

if [ ! -d "$BASEDIR"/log ]; then
    mkdir "$BASEDIR"/log
fi
cd "$BASEDIR" || { printf "cd failed, exiting\n" >&2;  return 1; }
echo "################################################################"
echo "build info: ""$PRGDIR"
echo "################################################################"
files=$(find . -type f -size +50M)
for f in $files
do
   echo "$f"
done