#!/bin/bash
. ./convert.sh

end="\033[0m"

echo -e $1$2'HOSTNAME =' $3$4$(hostname)$end

echo -e $1$2'TIME ZONE =' $3$4$(timedatectl | grep "Time zone" | awk '{print $3}') 'UTC' $(timedatectl | grep "Time zone" | awk '{print substr($5, 0, 1) sqrt($5^2)/100}')$end

echo -e $1$2'USER =' $3$4$(whoami)$end

echo -e $1$2'OS =' $$4$(uname) $(hostnamectl | grep "Operating System:" | awk '{ print $3, $4 }')$end

echo -e $1$2'DATE =' $3$4$(date | awk '{ print $2, $3, $4, $5 }')$end

echo -e $1$2'UPTIME =' $3$4$(uptime | awk '{ split($3, parts, ","); print parts[1]  }')$end

echo -e $1$2'UPTIME_SEC =' $3$4$(cat /proc/uptime | awk '{ print $1 }')$end

echo -e $1$2'IP =' $3$4$(ip -4 a | grep -m 2 "inet" | grep -v '127.0.0.1' | awk '{print $2}')$end

echo -e $1$2'MASK =' $3$4$(convert "$(ip -4 a | grep -m 2 "inet" | grep -v '127.0.0.1' | awk '{ split($2, parts, "/"); print parts[2] }')") $end
echo -e $1$2'GATEWAY =' $3$4$(ip r | grep "default" | awk '{print $3}')$end

echo -e $1$2'RAM_TOTAL ='$3$4 $(RAM 1)$end
echo -e $1$2'RAM_USED ='$3$4 $(RAM 2)$end
echo -e $1$2'RAM_FREE ='$3$4 $(RAM 3)$end

echo -e $1$2'SPACE_ROOT ='$3$4 $(space 1)$end
echo -e $1$2'SPACE_ROOT_USED ='$3$4 $(space 2)$end
echo -e $1$2'SPACE_ROOT_FREE ='$3$4 $(space 3)$end
