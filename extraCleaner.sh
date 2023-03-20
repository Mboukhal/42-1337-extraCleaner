#!/bin/bash

# remove all files above 60M

SizeLimit="60"

ROOT_PATH="$HOME"

cd $ROOT_PATH

rm -rf "/Users/$USER/Library/Caches/vscode-cpptools/ipch"

InitialStorage=$(df -h "$ROOT_PATH" | grep "$ROOT_PATH" | awk '{print($4)}')
printf "\n\033[31m\tTotal storage:\t\t[ ${InitialStorage} ] \033[0m\n\n"

GrepQuery="[$(($SizeLimit/10))-9][0-9]M \|[0-9]G \|[0-9][0-5][0-9]M "

ToRemove=($(ls -lhaR . 2>&1 | grep "M \|G " | grep "$GrepQuery" | awk {'print($9)'} 2>&1))

for i in ${!ToRemove[@]}; do

	RemoveIt=`find $ROOT_PATH -type f -name ${ToRemove[$i]} 2> /dev/null`
	rm "$RemoveIt" 2> /dev/null
	printf "\033[31mRemoved: \033[0m$RemoveIt\n"
done

NewStorage=$(df -h "$ROOT_PATH" | grep "Gi" | awk '{print($4)}' )

printf "\n\033[32m\tCleaning Resolt:\t[ ${NewStorage} ]  \033[0m\n"

cd - > /dev/null
