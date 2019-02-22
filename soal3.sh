#!/bin/bash

number=1
suffix=1
while test -e "password$suffix.txt";
        do
                ((++number))
                suffix="$number"
        done
fname="password$suffix.txt"
randomnum=$(</dev/urandom tr -dc A-Z-a-z-0-9 | head -c12)
echo "$randomnum" > "$fname"
