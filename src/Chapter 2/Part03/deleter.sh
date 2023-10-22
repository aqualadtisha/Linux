#!/bin/bash

logDel() {

    while IFS="" read -r line
        do
            if [[ ! $line =~ [.] && $line =~ [/] ]]; then
                sudo rm -rf $line
                # echo $line
            fi
        done < ../ex02/log.txt

}

dataDel() {
    paths=$(sudo find / -type f -newerct "$start" ! -newerct "$end" 2>/dev/null)

    echo "${paths[@]}"

    reg="^.*[a-zA-Z/]_[0-9]{6}\.[a-zA-Z]+$"

    if [ "${#paths[@]}" -gt "0" ]; then

        for str in ${paths[@]}
        do
            if [[ "$str" =~ $reg ]]; then
                sudo rm -rf "$str" 2>/dev/null
                # echo "$str"
            fi
        done
    fi

}

maskDel() {

 local paths=($(ls -l "$1" 2> /dev/null | awk '{print $9}')) # grep -v "bin"
  
  if [ "${#paths[@]}" -gt "0" ]; then

    for str in ${paths[@]}
    do
        if [[ $str =~ ^["$Symb"]+"_"$Date"".*$ ]]; then
            sudo rm -rf ""$1"$str" 2>/dev/null
            # echo ""$1"$str"
            continue
        fi
        maskDel ""$1""$str"/"
    done

  fi

}
