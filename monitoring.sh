#!/bin/bash

LVM=$(lvdisplay | awk 'NR == 8 {print $3}')

echo "#Architechure: $(uname -a)"
echo -n "#CPU pysical: "
lscpu | grep "CPU(s):" | awk 'NR == 1 {print $2}'
echo -n "#vCPU: "
lscpu | grep "socket" | awk '{print $4}'
free --mega | awk 'NR == 2 {printf("#Memory usage: %i/%iMB (%.2f%%)\n"), $3, $2, $3/$2*100}'
df -h | awk '$NF=="/"{printf "#Disk Usage: %i/%iGB (%s)\n", $3, $2, $5}'
top -bn1 | grep load | awk '{printf "#CPU Load: %.2f\n", $(NF-2)}'
who -b | awk '{printf "#Last boot: %s %s\n", $3, $4}'
echo -n "#LVM use: "
if [ $LVM == "available" ]
then
        echo yes
else
        echo  no
fi
ss -s | awk 'NR == 7 {printf "#Connections TCP: %i ESTABLISHED\n", $2}'
w | wc -l | awk 'NR == 1 {printf "#User log: %i\n", $1 - 2}'
echo -n "#NETWORK: IP "
echo -n "$(hostname -I)"
echo "($(cat /sys/class/net/enp0s3/address))"
echo "#Sudo: $(cat /var/log/sudo.log | wc -l) cmd"
