#!/bin/bash

lowerCase=(a b c d e f g h i j k l m n o p q r s t u v w x y z)
upperCase=(A B C D E F G H I J K L M N O P Q R S T U V W X Y Z)


for file in encrypted/*.txt
do
    hour=${file:10:2}
    hour=${hour:1:2}
    let reverse=$hour*-1
    filename=${file:10:16}
    lower=${lowerCase[$reverse]}
    upper=${upperCase[$reverse]}

    cat "$file" | tr '[a-z]' "[$lower-za-$lower]" | tr '[A-Z]' "[$upper-ZA-$upper]" >> decrypted/"$filename".txt
done
