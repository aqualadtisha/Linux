#!/bin/bash

. ./deleter.sh

args=$#

if [ "$args" -ne "1" ]
then
  echo "Invalid amount of parameters"
elif [[ ! $1 =~ ^[1-3]+$ || $1 -gt "3" ]]
then
  echo "Invalid type parameter"
elif [ "$1" -eq "1" ]
then
  logDel
elif [ "$1" -eq "2" ]
then
  echo "Enter start point in format YYYY-MM-DD HH:MM:00 : "
  read start
  echo "Enter end point in format YYYY-MM-DD HH:MM:00 : "
  read end

  reg="^[0-9]{4}-[0-9]{2}-[0-9]{2}\ [0-9]{2}:[0-9]{2}:[0-9]{2}$"

  if [[ "$start" =~ $reg && "$end" =~ $reg ]]; then
    dataDel
  else
    echo "Incorrect input"
  fi

elif [ "$1" -eq "3" ]
then
  echo "Enter the symbols: "
  read Symb
  echo "Enter date in format DDMMYY: "
  read Date

  echo "Deleting in proccess..."
  maskDel "/"
fi
