# Ransomware

## Description

Black-hat hackers infected one of the main servers of the water treatment station with custom ransomware.
They have encrypted very important files required for smooth operation of the facility.
Access the infected machine and check if the hackers left anything behind that would help you with recovering the data.

# Writeup

-   Participant gets an interactive shell.
-   Participant finds out that `/home` directory contains some files with some unknown data.
-   Participant finds `.bash-history` file left by the hackers which contains a command that executes some obfuscated script downloaded from the Internet.
-   Participant analyzes the downloaded bash script and finds out that every file in `/home` directory has been encrypted with OpenSSL using AES-256-CBC algorithm.
-   Participant finds out that the script encrypted each file with a random password from `rockyou.txt` wordlist (one password for every file).
-   Participant writes a script that bruteforces encrypted files with passwords from `rockyou.txt` wordlist.
-   Participant ends up with decrypted `/home` directory.
-   Participant analyzes the decrypted files and finds a hint saying that "Jeff knows something".
-   Participant finds a `passwords.db` database containing many usernames and passwords (base64 encoded).
-   Participant opens `passwords.db` database in some kind of SQLite3 database explorer and finds the flag in the row with username jeff.
-   Participant submits the flag to the ticket system.

# Sources

-   [How to use OpenSSL to encrypt/decrypt files?](https://stackoverflow.com/a/16056298/12126676)
-   [rockyou.txt wordlist](https://raw.githubusercontent.com/praetorian-inc/Hob0Rules/master/wordlists/rockyou.txt.gz)
-   [SQLite usage with python](https://docs.python.org/3/library/sqlite3.html)
-   [DB Browser for SQLite](https://sqlitebrowser.org/)
