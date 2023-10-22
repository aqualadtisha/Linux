#!/bin/bash

. ./generator.sh

args=$#

if [ "$args" -ne "6" ]
then
  echo "Invalid amount of parameters"
elif [[ ! $6 =~ ^[0-9kb]+$ ]]
then
  echo "Invalid size parameters"
elif [[ "${6%??}" -gt "100" || "${6%??}" -le "0" ]]
then
  echo "Invalid size amount"
elif [[ ! $3 =~ ^[a-zA-Z]+$ ]] || [[ ! $5 =~ ^[a-zA-Z.]+$ ]]
then
  echo "Invalid words parameters"
elif [[ ! $2 =~ ^[1-9]+$ || ! $4 =~ ^[1-9]+$ ]]
then
  echo "Invalid count parameters"
elif [[ "${#3}" -gt "7" || "${#3}" -le "0" ]]
then
  echo "Invalid words amount (3)"
else
  IFS='.' read -r -a array <<< "$(echo "$5")"
  read -r -a wordsFiles <<< "$(echo "${array[0]}" | sed 's/\(.\)/\1 /g')"
  read -r -a fileExt <<< "$(echo "${array[1]}" | sed 's/\(.\)/\1 /g')"
  if [[ "${#wordsFiles[@]}" -gt "7" || "${#wordsFiles[@]}" -le "0" || "${#fileExt[@]}" -gt "3" || "${#fileExt[@]}" -le "0" ]]
  then
    echo "Invalid words amount (5)"
    exit 1
  fi

  sizekb="$6"
  path="$1"
  folds="$2"
  read -r -a wordsFolds <<< "$(echo $3 | sed 's/\(.\)/\1 /g')"
  files="$4"
  date=$(date "+%d%m%y")

  echo "" > log.txt
  folderGen

fi
