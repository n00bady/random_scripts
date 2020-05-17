#!/bin/bash
#
# attacker - prints out the last failed login attempt
#
echo "The last failed login attempt came form IP address:"
grep -i "disconnected from" /var/log/auth.log | tail -1 | cut -d: -f4 | cut -f7 -d" "
#
# topattack - list the most persistent attackers
#
if [ -z "$1" ]; then
    echo -e "\nUse: '$0' <int> - Lists the top <int> attackers by IP"
    exit 0
fi
echo " "
echo "Persistand recent attackers"
echo " "
echo "Attempts      IP"
echo "------------------------"
grep "Disconnected from authenticating user root" /var/log/auth.log | cut -d: -f 4 | cut -d" " -f7 | sort | uniq -c | sort -nr | head -$1

