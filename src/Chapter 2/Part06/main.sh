#!/bin/bash

html="/usr/share/nginx/html/exporter.html"

while true
do
    echo "CPU $(mpstat -P 0 | tail -1 | awk '{print 100-$13}')" > $html
    echo "RAM_USED $(free / | grep "Mem" | awk '{print $3}')" >> "$html"
    echo "DISK_FREE $(df / | tail -1 | awk '{print $4}')" >> "$html"
    sleep 1
done