#!/usr/bin/python3
import time
import requests
import gzip
import glob
import os
import sys

if len(sys.argv) != 2:
    exit(1)

decrypt_dir = sys.argv[1]
print(f"Decrypt directory: {decrypt_dir}")

url = "https://raw.githubusercontent.com/praetorian-inc/Hob0Rules/master/wordlists/rockyou.txt.gz"
r = requests.get(url, stream=True)
passwords = gzip.decompress(r.raw.data).splitlines()

last_status_timestamp = time.time()


def try_password(password: str):
    for filename in glob.iglob(decrypt_dir + '**/**', recursive=True):
        if not os.path.isfile(filename):
            continue

        command = f"openssl aes-256-cbc -d -salt -in \"{filename}\" -k \"{password}\""
        exit_code = os.system(command)

        if exit_code != 0:
            return False

        print(f"\n\n\n\n\n\nFound password: {password}")

        return True


for i in range(len(passwords)):
    password = passwords[i].decode(errors='ignore')

    if time.time() - last_status_timestamp >= 2:
        last_status_timestamp = time.time()
        percent = (i / len(passwords)) * 100
        print(f"Progress: {percent}%")

    if try_password(password):
        break
