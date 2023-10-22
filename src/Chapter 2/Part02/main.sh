#!/bin/bash

. ./generator.sh

start=$(date +"%H:%M:%S")
startSec=$(date +%s)

args=$#

if [ "$args" -ne "3" ]
then
  echo "Invalid amount of parameters"
elif [[ ! $3 =~ ^[0-9Mb]+$ ]]
then
  echo "Invalid size parameters"
elif [[ "${3%??}" -gt "100" || "${3%??}" -le "0" ]]
then
  echo "Invalid size amount"
elif [[ ! $1 =~ ^[a-zA-Z]+$ ]] || [[ ! $2 =~ ^[a-zA-Z.]+$ ]]
then
  echo "Invalid words parameters"
elif [[ "${#1}" -gt "7" || "${#1}" -le "0" ]]
then
  echo "Invalid words amount (1)"
else
  IFS='.' read -r -a array <<< "$(echo "$2")"
  read -r -a wordsFiles <<< "$(echo "${array[0]}" | sed 's/\(.\)/\1 /g')"
  read -r -a fileExt <<< "$(echo "${array[1]}" | sed 's/\(.\)/\1 /g')"
  if [[ "${#wordsFiles[@]}" -gt "7" || "${#wordsFiles[@]}" -le "0" || "${#fileExt[@]}" -gt "3" || "${#fileExt[@]}" -le "0" ]]
  then
    echo "Invalid words amount (2)"
    exit 1
  fi

  sizekb="$3"
  read -r -a wordsFolds <<< "$(echo $1 | sed 's/\(.\)/\1 /g')"
  date=$(date "+%d%m%y")

  echo "" > log.txt
  searchPath "/"

  timerRes
fi
