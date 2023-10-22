#!/bin/bash

args=$#

if [ "$args" -ne 1 ]
then
    echo "Invalid amount of parameters"
    exit 1
else
    tmp=$(echo $1 | awk '{ n=split($0, parts, "\"); print parts[n] }')
    if [ "$tmp" != "" ]
    then
        echo "Invalid path. Try again"
        exit 1
    fi
fi

chmod +x monitoring2.sh
bash monitoring2.sh "$1"
