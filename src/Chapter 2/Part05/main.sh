#!/bin/bash

args=$#

if [ "$args" -ne "1" ]
then
  echo "Invalid amount of parameters"
elif [[ ! $1 =~ ^[1-4]+$ || $1 -gt "4" ]]
then
  echo "Invalid type parameter"
else
  files=$(ls -l "../Part04" 2> /dev/null | awk '{print "../Part04/"$9}' | grep ".log" | grep "access")

  if [ "$1" -eq "1" ]; then
      awk '{ print $0 }' $files | sort -k 8 >> resultCode.txt
  elif [ "$1" -eq "2" ]; then
      awk '{ print $1 }' $files | sort -k 1 | uniq >> resultIp.txt
  elif [ "$1" -eq "3" ]; then
      awk '$8 ~ /^[4-5]/ { print $8, $5, $6, $7, $10 }' $files >> resultErrors.txt
  elif [ "$1" -eq "4" ]; then
      awk '$8 ~ /^[4-5]/ { print $1 }' $files | uniq >> resultErrorsIP.txt
  fi
fi
