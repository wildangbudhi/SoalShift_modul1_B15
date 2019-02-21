#!/bin/bash

arr=()
num=1
keepadd=1
pass=""
passf=0

#Randomizing password 12 char a-ZA-Z0-9
function genpass () {
	pass=`head /dev/urandom | tr -dc A-Za-z0-9 | head -c 12`
}

#Check element in array
function ce () {
	passf=0
	for e in ${arr[@]}
	do
		if [ "$pass" -eq "$e" ]
		then
			passf=1
			break
		fi
	done
}

#Checking password to array
for files in ./password_*.txt; do
	array+=(`cat $files`)
	if [ $keepadd -eq 1 ]
	then
		if [ "$files" != "./password_$num.txt" ]
		then
			keepadd=0
			break
		fi
	fi
	num=$((num + 1))
done

while [ 1 -eq 1 ]; do
	genpass
	ce
	if [ $passf == 0 ]
	then
		break
	fi
done

echo $pass > "./password_$num.txt"