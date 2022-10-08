#!/bin/sh

seed=$(head -n 1 /tmp/encrypt.log)
ts1=$(($seed-25))
ts2=$(($seed-22))
ts3=$(($seed-19))
ts4=$(($seed-15))
ts5=$(($seed-10))
ts6=$(($seed+12))

sed -i -e "s/{ts1}/${ts1}/g" /home/ftp/.bash_history
sed -i -e "s/{ts2}/${ts2}/g" /home/ftp/.bash_history
sed -i -e "s/{ts3}/${ts3}/g" /home/ftp/.bash_history
sed -i -e "s/{ts4}/${ts4}/g" /home/ftp/.bash_history
sed -i -e "s/{ts5}/${ts5}/g" /home/ftp/.bash_history
sed -i -e "s/{ts6}/${ts6}/g" /home/ftp/.bash_history
sed -i -e "s/{seed}/${seed}/g" /home/ftp/.bash_history