#!/bin/bash
# sudo apt install p7zip-full p7zip-rar
function_express() {
    echo $1
    filename=$1
    filename_dir="$filename"".dir"
    cd "$filename_dir" || exit
    find . -type f |awk -F' ' '{print $1}'|head -n 1 |xargs 7z e
    mv "$filename" ../
}
function_express test