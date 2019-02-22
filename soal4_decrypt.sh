echo "Enter the file: "
read times
hour=${times:0:2}

lowercase="abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz"
uppercase="ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ"
awk '{print}' "/home/hp/sisop1/soal4_encrypt/$times" | tr "${lowercase:$hour:26}${uppercase:$hour:26}" "${lowercase:0:26}${uppercase:0:26}" | awk '{print}' > "/home/hp/sisop1/soal4_decrypt/$times"
