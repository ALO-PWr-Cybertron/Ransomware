# Ransomware

## Build

```
docker build . -t cybertron-7-ransomware --build-arg flag=`cat flag.txt`
```

## Description

Black-hat hackers infected one of the main servers of the water treatment station with custom ransomware.
They have encrypted very important files required for smooth operation of the facility.
Access the infected machine and check if the hackers left anything behind that would help you with recovering the data.

In your Kubernetes namespace there is a pod with a name like: `cybertron-7-ransomware`.
It has SSH server listening on port 22.
Username: `ftp`
Password: `ftp`

# Writeup

-   Participant gets an interactive shell.
-   Participant finds out that `/home` directory contains files with unknown data.
-   Participant finds `.bash_history` file left by the hackers, which contains a command that executes a .jar file.
-   Participant decompiles the .jar file and finds out that every file in `/home` directory has been encrypted with OpenSSL AES-256-CBC algorithm using a random generated password.
-   Participant exploits a vulnerability in random password generator (cryptographically insecure seed) and reverse engineers the password.
-   Participant decrypts the `/home` directory.
-   Participant analyzes the decrypted files and finds a hint refering to employee named Jeff.
-   Participant finds a `database.db` file and opens it using SQLite3.
-   Participant finds an employee named Jeff and decodes his password using base64 encoding.
-   Participant submits the flag to the ticket system.

# Sources

-   [How to use OpenSSL to encrypt/decrypt files?](https://stackoverflow.com/a/16056298/12126676)
-   [SQLite usage with python](https://docs.python.org/3/library/sqlite3.html)
-   [DB Browser for SQLite](https://sqlitebrowser.org/)
