#!/bin/bash
if [ -f "./config.cfg" ]
then
        source "./config.cfg"
else
        echo "Can't find config file: "config.cfg""
        exit 1
fi

. ../functions/colours.sh

setConfig

if [ $f1 -eq $b1 ] || [ $f2 -eq $b2 ]
then
        echo "The same parameters for font and back. Try again"
else
    f1=${column1_font_color:=1}
    f2=${column2_font_color:=2}
    b1=${column1_background:=3}
    b2=${column2_background:=4}

    font1="\033[$(($(colours $f1) + 10))m"
    font2="\033[$(($(colours $f2) + 10))m"
    back1="\033[$(colours $b1)m"
    back2="\033[$(colours $b2)m"

    chmod +x ../functions/monitoringColours.sh
    bash ../functions/monitoringColours.sh "$font1" "$back1" "$font2" "$back2"

    echo "Column 1 background = $b1 ($(colourName ${column1_background:=10}))"
    echo "Column 1 font color = $f1 ($(colourName ${column1_font_color:=10}))"
    echo "Column 2 background = $b2 ($(colourName ${column2_background:=10}))"
    echo "Column 2 font color = $f2 ($(colourName ${column2_font_color:=10}))"
fi
