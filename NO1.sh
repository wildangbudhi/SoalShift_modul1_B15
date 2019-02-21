#!/bin/bash

unzip nature.zip -d "./"
data=`ls nature`
i=0
mkdir "hasil"

for name in ${data[@]}
do
    echo "Decode :  $name"
    base64 --decode "./nature/$name" | xxd -r > "./hasil/$i.jpeg"
    i=$(($i+1))
done