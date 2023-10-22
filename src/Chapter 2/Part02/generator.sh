#!/bin/bash

count=0
shift=0
amount=1
word=0
max=0
str=""
arr=()

generator() {
  for (( i=0; i<"$word"; i++ ))
  do
    if [[ "$i" -eq "$shift" ]]
    then
      charAdd "${arr[i]}" "$amount"
      ((amount += 1))
    else
      str+="${arr[i]}"
    fi

    if [ "$amount" -ge "$max" ]; then
      (( shift += 1 ))
      amount=1
    fi

    if [ "$shift" -ge "$word" ]; then
      break
    fi
  done
}

folderGen() {
  local amountFold=0
  local shiftFold=0
  local pathFold="$path"

  while [ "$count" -lt "100" ]
  do
    word=${#wordsFolds[@]}
    (( max=250-$word ))
    arr=(${wordsFolds[*]})

    generator

    if [ ${#str} -ge "5" ]; then
      str+="_""$date"
      if [ ! -d "$path$str" ]; then
        sudo mkdir "$path""$str" 2>/dev/null
        # echo "mkdir "$path"/"$str""
        echo "$path$str $date $sizekb" >> log.txt
        memory=$(df . | tail -1 | awk '{print int($4/1024/1024)}')
        if [ "$memory" -lt "1" ]; then
          timerRes
          exit
        fi
        ((count += 1))
      fi

      amountFold="$amount"
      shiftFold="$shift"
      countFold="$count"
      path+="$str/"
      str=""
      fileGen

      amount="$amountFold"
      shift="$shiftFold"
      count="$countFold"
      path="$pathFold"

    fi
    str=""
  done
}

charAdd() {
  local j=0
  while [ "$j" -lt "$2" ]
  do
    str+="$1"
    ((j += 1))
  done
}

fileGen() {
    amount=1
    count=0
    shift=0
  word=${#wordsFiles[@]}
  (( max=250-$word ))

  files=$RANDOM
  while [ "$count" -lt "$files" ]
  do
    arr=(${wordsFiles[*]})
    (( max=250-$word ))
    generator

    if [ ${#str} -ge "5" ]; then
      str+="_""$date""."
      (( max=255-${#str} ))
      local ext=${#fileExt[@]}

      if [ "$max" -lt "$ext" ]; then
        (( shift += 1 ))
        break
      fi
      local strMain="$str"
      local shiftMain="$shift"
      local amountMain="$amount"
      shift=0
      amount=1
      arr=(${fileExt[*]})

      while [ "$count" -lt "$files" ]
      do
       generator
      #  echo "fallocate "$path"/"$str""
       sudo fallocate -l "$sizekb" "$path""$str" 2>/dev/null
       echo "$path$str $date $sizekb" >> log.txt
       memory=$(df . | tail -1 | awk '{print int($4/1024/1024)}')
      if [ "$memory" -lt "1" ]; then
        timerRes
        exit
      fi
        ((count += 1))
        str="$strMain"
        if [ "$shift" -ge "$ext" ]; then
          break
        fi
      done
      shift="$shiftMain"
      amount="$amountMain"
    fi
    str=""
  done
}

searchPath() {
  local paths=($(ls -l "$1" 2> /dev/null | grep "^d" | grep -v "boot" | awk '{print $9}')) # grep -v "bin"
  
  if [ "${#paths[@]}" -gt "0" ]; then

    for i in ${paths[@]}
    do
      # searchPath ""$1"/"$i""
      searchPath ""$1""$i"/"
    done

  fi

  path="$1"
  folderGen
}

timerRes() {
  end=$(date +"%H:%M:%S")
  endSec=$(date +%s)
  scriptTime=$(( $endSec - $startSec ))

  echo "Script start at: $start"
  echo "Script start at: $start" >> log.txt
  echo "Script end at: $end"
  echo "Script end at: $end" >> log.txt
  echo "Script running time: $scriptTime sec"
  echo "Script running time: $scriptTime sec" >> log.txt
}