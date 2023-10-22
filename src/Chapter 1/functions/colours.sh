#!/bin/bash

f1=1
f2=4
b1=6
b2=2

setConfig() {
    if [[ -n ${column1_font_color} ]]
        then f1=${column1_font_color}
    fi

    if [[ -n ${column2_font_color} ]]
        then f2=${column2_font_color}
    fi

    if [[ -n ${column1_background} ]]
        then b1=${column1_background}
    fi

    if [[ -n ${column2_background} ]]
        then b2=${column2_background}
    fi
}

colours() {
    case $1 in
    1) echo 97;; #white
    2) echo 31;; #red
    3) echo 32;; #green
    4) echo 36;; #blue
    5) echo 35;; #purple
    6) echo 30;; #black
    esac
}

colourName() {
    case $1 in
    1) echo "white";; 
    2) echo "red";;
    3) echo "green";;
    4) echo "blue";;
    5) echo "purple";;
    6) echo "black";;
    esac
}