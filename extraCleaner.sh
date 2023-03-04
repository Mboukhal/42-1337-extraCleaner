#!/bin/bash

# remove all files above 60M

cd ~/

input="/tmp/tmp.clean"

ls -lhaR ~/ 2>&1 | grep "M \|G " | grep  '[6-9][0-9]M \|[0-9]G \|[0-9][0-5][0-9]M ' > $input 2>&1

while read -r line
do
        x=`echo $line | awk {'print($9)'}`
        r=`find ~/ -name $x 2>/dev/null`
        rm "$r" 2> /dev/null
        printf "\033[31m$r\tRemoved.\033[0m\n"
done < "$input"

printf "\033[32mExtra clean done\033[0m\n"
rm $input

cd -
