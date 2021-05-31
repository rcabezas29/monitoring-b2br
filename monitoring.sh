#!/bin/bash

echo "#Architechure: $(uname -a)"
echo -n "#CPU physical: "
lscpu | grep "CPU(s):" | awk 'NR == 1 {print $2}'
echo -n "#vCPU: "
lscpu | grep "socket" | awk '{print $4}'
free --mega | awk 'NR == 2 {printf("#Memory usage: %i/%iMB (%.2f%%)\n"), $3, $2, $3/$2*100}'
df -h | awk '$NF=="/"{printf "#Disk Usage: %i/%iGB (%s)\n", $3, $2, $5}'
top -bn 1 | awk 'NR == 3 {printf "#CPU Load: %.2f%%\n", $2+$4}'
who -b | awk '{printf "#Last boot: %s %s\n", $3, $4}'
lvm pvdisplay | awk 'NR == 5 {printf "#LVM use: %s\n", $2}'
ss -s | awk 'NR == 7 {printf "#Connections TCP: %i ESTABLISHED\n", $2}'
w | wc -l | awk 'NR == 1 {printf "#User log: %i\n", $1 - 2}'
echo -n "#NETWORK: IP "
echo -n "$(hostname -I)"
echo "($(cat /sys/class/net/enp0s3/address))"
echo "#Sudo: $(cat /var/log/sudo/sudo.log | grep "COMMAND" | wc -l) cmd"
