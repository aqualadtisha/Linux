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

  while [ "$count" -lt "$folds" ]
  do
    word=${#wordsFolds[@]}
    (( max=250-$word ))
    arr=(${wordsFolds[*]})

    generator

    if [ ${#str} -ge "4" ]; then
      str+="_""$date"
      if [ ! -d "$path/$str" ]; then
        mkdir "$path"/"$str"
        echo "$path/$str $date $sizekb" >> log.txt
        memory=$(df / | tail -1 | awk '{print int($4/1024/1024)}')
        if [ "$memory" -lt "1" ]; then
          exit
        fi
        ((count += 1))
      fi

      amountFold="$amount"
      shiftFold="$shift"
      countFold="$count"
      path+="/$str"
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
  while [ "$count" -lt "$files" ]
  do
    arr=(${wordsFiles[*]})
    (( max=250-$word ))
    generator

    if [ ${#str} -ge "4" ]; then
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
        if [ ! -f "$path/$str" ]; then
          fallocate -l "$sizekb" "$path"/"$str"
          echo "$path/$str $date $sizekb" >> log.txt
          memory=$(df / | tail -1 | awk '{print int($4/1024/1024)}')
          if [ "$memory" -lt "1" ]; then
            exit
          fi
          ((count += 1))
        fi
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
