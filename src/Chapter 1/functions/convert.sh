#!/bin/bash

convert() {
    local mask=""
    local prefix=$1
    local maskpart=0
    local part=128
    local full=$((prefix / 8))
    local section=$((prefix % 8))
    local i=0
    while [ $full -gt 0 ]
    do
        ((i+=1))
        mask+="255."; ((full-=1))

    done

    for((; i<4; i++))
    do
        if [ $section -gt 0 ]
        then
            while [ $section -gt 0 ]
            do
                ((maskpart+=part))
                ((part/=2))
                ((section-=1))
            done
            mask+=$maskpart
        else
            mask+="0"
        fi
        if [ $i -lt 3 ]
        then
            mask+="."
        fi
    done
    echo "$mask"
}

RAM() {
    local pos=$1
    local res=$(free | grep "Mem:")
    local i=0
    for item in ${res[*]}
    do
        if [ $i -eq $pos ]
        then
            printf "%0.3f GB\n" $(echo "scale=3; $item/1024/1024" | bc)
            return
        fi
        ((i+=1))
    done
}

space() {
    local pos=$1
    local res=$(df / | grep "/dev")
    local i=0
    for item in ${res[*]}
    do
        if [ $i -eq $pos ]
        then
            printf "%0.2f MB\n" $(echo "scale=2; $item/1024" | bc)
            return
        fi
        ((i+=1))
    done
}

findExtension() {
    echo $(ls -lR | grep "^-" | grep "$1" | wc | awk '{ print $1 }')
}

totalNumb() {
    echo $(ls -lR | grep "$1" | wc | awk '{ print $1 }')
}
