#!/bin/bash
# sudo apt install p7zip-full p7zip-rar
filename="target_file"
filename_dir="$filename"".dir"
mkdir -p filename_dir
7z a -v1M "./""$filename_dir/""$filename"".7z" "./""$filename"