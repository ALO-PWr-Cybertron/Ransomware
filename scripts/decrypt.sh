# curl https://raw.githubusercontent.com/praetorian-inc/Hob0Rules/master/wordlists/rockyou.txt.gz -o rockyou.txt.gz
# gzip -d rockyou.txt.gz

bruteforce-salted-openssl -t 10 -f rockyou.txt -d sha256 data/test.txt.enc