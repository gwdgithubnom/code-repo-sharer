#!/bin/bash
function_express() {
    filename=$1
    if [[ "$filename" == *".dir" ]]
    then
       filename=${1//.dir/}
    fi
    filename_dir="$filename"".dir"
    file="$(basename "${filename}")"
    echo "do expression on $filename_dir about $filename from $1"
    from_dir=$(pwd)
    cd "$filename_dir" || exit
    find . -type f |awk -F' ' '{print $1}'|head -n 1 |xargs 7z e
    mv "$file" "$(dirname "${filename}")""/"
    cd "$from_dir" || exit
}

function_compress() {
    filename=$1
    filename_dir="$filename"".dir"

    if [[ "$f" == *".dir" ]]
    then
       filename_dir=$f
    fi
    echo "do compress on $filename_dir about $filename from $1"
 
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

PRGDIR=$(pwd "$(dirname "$PRG")")
BASEDIR=$(cd "$PRGDIR/.." >/dev/null || exit; pwd)

if [ ! -d "$BASEDIR"/log ]; then
    mkdir "$BASEDIR"/log
fi
cd "$BASEDIR" || { printf "cd failed, exiting\n" >&2;  return 1; }
echo "################################################################"
echo "build info: ""$PRGDIR"
echo "################################################################"
# "$(pwd -P)"
files=$(find "$PRGDIR" -name "*.dir" -type d)
for f in $files
do
   # cd "$f" || exit
   function_express "$f"
   rm -r "$f"
done