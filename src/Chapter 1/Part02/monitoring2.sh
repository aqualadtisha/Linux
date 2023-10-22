#!/bin/bash
. ../functions/colours.sh

path="$1"

START=$(date +%s)

echo "Total number of folders (including all nested ones) =" $(totalNumb "^d")

echo "TOP 5 folders of maximum size arranged in descending order (path and size):"
du -h "$path" | sort -rh | head -5 | nl | awk '{ printf "%d - %s, ", $1, $3; print $2 }'

echo "Total number of files =" $(totalNumb "^-") 

echo "Number of:"
echo "Configuration files (with the .conf extension) =" $(findExtension ".cfg") 
echo "Text files =" $(findExtension ".txt") 
echo "Executable files =" $(find . -executable -type f | wc | awk '{ print $1 }')
echo "Log files (with the extension .log) =" $(findExtension ".log") 
echo "Archive files =" $(findExtension ".zip")
echo "Symbolic links =" $(totalNumb "^l")

echo "TOP 10 files of maximum size arranged in descending order (path, size and type):"
find "$path" -type f -exec du -ch {} + | sort -nr | head | nl | awk '{
    n=split($3, parts, ".");
    printf "%d - %s, ", $1, $3;
    OFS=", ";
    if (n < 2) { print $2,"none" }
    else { print $2,parts[n] } }'


echo "TOP 10 executable files of the maximum size arranged in descending order (path, size and MD5 hash of file):"
find "$path" -type f  -executable -exec du -sh {} + | sort -nr | head | nl | awk '{
    str="echo " $3 "| md5sum";
    str | getline md5;
    printf "%d %s, %s, %s\n", $1, $3, $2, md5
    }' | awk '{printf "%d - %s %s %s\n", $1, $2, $3, $4}'

END=$(date +%s)
echo -e "Script execution time (in seconds) =" $(echo "scale=10; (($END - $START))" | bc)