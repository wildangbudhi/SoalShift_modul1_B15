#!/bin/bash

awk '
(!(/[sS][uU][dD][oO]/) && (/[cC][rR][oO][nN]/) && (NF<13))
' /var/log/syslog > /home/wildangbudhi/modul1
