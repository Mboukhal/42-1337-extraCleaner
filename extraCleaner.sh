#!/bin/bash

# remove all files above 60M

input="/tmp/tmp.clean"

ls -lhaR ~/ 2>&1 | grep "M \|G " | grep  '[6-9][0-9]M \|[0-9]G \|[0-9][0-5][0-9]M ' > $input 2>&1

while read -r line
do
        x=`echo $line | awk {'print($9)'}`
        echo $x
        r=`find ~/ -name $x 2>/dev/null`
        echo $r
        rm "$r" 2> /dev/null
        echo -e "\033[31m$r Removed.\033[0m"
done < "$input"

echo -e "\033[32mExtra clean done\033[0m"
rm $input
