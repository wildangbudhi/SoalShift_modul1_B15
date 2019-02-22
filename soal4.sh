#!/bin/bash

upper=ABCDEFGHIJKLMNOPQRSTUVWXYZ
lower=abcdefghijklmnopqrstuvwxyz
DATE=`date '+%H:%M %d-%m-%Y'`
n=`date '+%H'`
tr "$upper$lower" "${upper:n}${upper:0:n}${lower:n}${lower:0:n}" <<< `cat /var/log/syslog` > ~/sisop1/"$DATE"
