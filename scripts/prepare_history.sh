#!/bin/sh

seed=$(head -n 1 /tmp/encrypt.log)
ts1=$(($seed-25))
ts2=$(($seed-22))
ts3=$(($seed-19))
ts4=$(($seed-15))
ts5=$(($seed-10))
ts6=$(($seed+12))

echo "#${ts1}\nwhoami\n#${ts2}\nls -la\n#${ts3}\ntree /home\n#${ts4}\ncat /etc/passwd\n#${ts5}\nuname -a\n#${seed}\njava -jar /tmp/ransomware.jar /home/ftp/Documents\n#${ts6}\necho 'YOU HAVE BEEN PWNED DUMBASS!!!' > PWNED.txt" > /home/ftp/.bash_history