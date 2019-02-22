hour=`date +"%H"`
filename=`date +"%H:%M %d-%m-%Y"`

lowercase="abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz"
uppercase="ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ"

cat /var/log/syslog | tr "${lowercase:0:26}${uppercase:0:26}" "${lowercase:$hour:26}${uppercase:$hour:26}" > "/home/hp/sisop1/soal4_encrypted/$filename"
