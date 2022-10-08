#!/bin/sh

database_path=$1

flag=$2
flag_encoded=`echo $flag | base64`

query="UPDATE employees SET password = '$flag_encoded' WHERE first_name = 'Jeff'"

echo "$query" | sqlite3 $1