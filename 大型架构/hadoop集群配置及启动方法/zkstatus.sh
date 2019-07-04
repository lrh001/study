#!/bin/bash
function get_zkstat(){
    exec 2</dev/null 8<>/dev/tcp/$1/2181
    echo "stat" >&8
    _S=$(cat <&8|grep -Po "^Mode:.*")
    echo -e "$1\t${_S:-Mode: NULL}"
    exec 8<&-
}

if (( $# == 0 ));then
   echo "Usage: $0 host1 host2 host3 ... ..."
else
   for i in $@;do get_zkstat ${i};done
fi
