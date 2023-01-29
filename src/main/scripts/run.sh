#!/bin/bash
function Get_repo_url() {
   app_name=$1
   repo=$2
   path=$3
   url=$4
   if [ -z "$app_name" ]
   then
      app_name="tmux"
      repo="https://github.com/mypublic-teamwork/code-repo-sharer.git"
      path="/main/doc/t/t.md"
      url=""
   elif [ -z "$repo" ]
   then
      repo="https://github.com/mypublic-teamwork/code-repo-sharer.git"
      path="/main/doc/t/t.md"
      url=""
   fi
   
   ########################################################################
   # path="/doc/t"
   # file="t.md"
   # host="raw.githubusercontent.com"
   ########################################################################

   if [ "$url" = "" ]
   then
      url=$(echo "$repo" |sed -e 's/github.com/raw.githubusercontent.com/;s/.git$//')
      url="$url""$path"
   fi
   repo_url=$(curl "$url" |grep "$app_name" |awk -F '[()]' '{print $2}')
   echo "$repo_url"
   
}
Get_repo_url tmux https://github.com/mypublic-teamwork/code-repo-sharer.git /main/doc/t/t.md

# cat t.md |awk -F'[()]' '{print $2}'
# git archive --format=tar --remote=origin HEAD:path/to/directory -- filename | tar -O -xf -
# git archive --remote=git://git.example.com/project.git refs/heads/mybranch path/to/myfile |tar xf -
# git archive --remote git://git@github.com:mypublic-teamwork/code-repo-sharer.git refs/heads/main doc/t/t.md | tar xf -
# git archive --remote git://git@github.com:mypublic-teamwork/code-repo-sharer.git refs/heads/main doc/t/t.md | tar xf -
# git archive --remote=https://github.com/mypublic-teamwork/code-repo-sharer.git HEAD doc/t/t.md
# https://raw.githubusercontent.com/mypublic-teamwork/code-repo-sharer/main/doc/t/t.md
