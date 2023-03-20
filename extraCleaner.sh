#!/bin/bash

# remove all files above 60M

SizeLimit="60"

ROOT_PATH="$HOME"

cd $ROOT_PATH


InitialStorage=$(df -h "$ROOT_PATH" | grep "$ROOT_PATH" | awk '{print($4)}')
printf "\n\033[31m\tTotal storage:\t\t[ ${InitialStorage} ] \033[0m\n\n"

GrepQuery="[$(($SizeLimit/10))-9][0-9]M \|[0-9]G \|[0-9][0-5][0-9]M "

ToRemove=($(ls -lhaR . 2>&1 | grep "M \|G " | grep "$GrepQuery" | awk {'print($9)'} 2>&1))

#42 Caches
rm -rf ~/Library/*.42* &>/dev/null
rm -rf ~/*.42* &>/dev/null
rm -rf ~/.zcompdump* &>/dev/null
rm -rf ~/.cocoapods.42_cache_bak* &>/dev/null

#Trash
rm -rf ~/.Trash/* &>/dev/null

#General Cache files
rm -rf ~/Library/Caches/* &>/dev/null
rm -rf ~/Library/Application\ Support/Caches/* &>/dev/null

#VSCode, Discord and Chrome Caches
rm -rf ~/Library/Application\ Support/Code/User/workspaceStorage/* &>/dev/null
rm -rf ~/Library/Application\ Support/discord/Cache/* &>/dev/null
rm -rf ~/Library/Application\ Support/discord/Code\ Cache/js* &>/dev/null
rm -rf ~/Library/Application\ Support/Google/Chrome/Profile\ [0-9]/Service\ Worker/CacheStorage/* &>/dev/null
rm -rf ~/Library/Application\ Support/Google/Chrome/Default/Service\ Worker/CacheStorage/* &>/dev/null
rm -rf ~/Library/Application\ Support/Google/Chrome/Profile\ [0-9]/Application\ Cache/* &>/dev/null
rm -rf ~/Library/Application\ Support/Google/Chrome/Default/Application\ Cache/* &>/dev/null

#tmp downloaded files with browsers
rm -rf ~/Library/Application\ Support/Chromium/Default/File\ System &>/dev/null
rm -rf ~/Library/Application\ Support/Chromium/Profile\ [0-9]/File\ System &>/dev/null
rm -rf ~/Library/Application\ Support/Google/Chrome/Default/File\ System &>/dev/null
rm -rf ~/Library/Application\ Support/Google/Chrome/Profile\ [0-9]/File\ System &>/dev/null

#ipch CPP
rm -rf ~/Library/Caches/* &>/dev/null

for i in ${!ToRemove[@]}; do

	RemoveIt=`find $ROOT_PATH -type f -name ${ToRemove[$i]} 2> /dev/null`
	rm "$RemoveIt" 2> /dev/null
	printf "\033[31mRemoved: \033[0m$RemoveIt\n"
done

NewStorage=$(df -h "$ROOT_PATH" | grep "Gi" | awk '{print($4)}' )

printf "\n\033[32m\tCleaning Resolt:\t[ ${NewStorage} ]  \033[0m\n"

cd - > /dev/null
