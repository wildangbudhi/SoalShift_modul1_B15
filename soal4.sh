#!/bin/bash

lowerCase=(a b c d e f g h i j k l m n o p q r s t u v w x y z)
upperCase=(A B C D E F G H I J K L M N O P Q R S T U V W X Y Z)

tgl=`date +"%d"`
bln=`date +"%m"`
thn=`date +"%Y"`
jam=`date +"%H"`
menit=`date +"%M"`

home="/home/hp/ss1/modul1"
namafile="$home/$jam:$menit $tgl-$bln-$thn.txt"

bawah=${lowerCase[$jam]}
atas=${upperCase[$jam]}

cat "/var/log/syslog" | tr '[a-z]' "[$bawah-za-$bawah]" | tr '[A-Z]' "[$atas-ZA-$atas]" > "$namafile"
