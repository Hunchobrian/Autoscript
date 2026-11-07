#!/bin/bash
for user in $(awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd); do
    exp_date=$(chage -l "$user" | grep "Account expires" | awk -F": " '{print $2}')
    if [[ "$exp_date" != "never" ]]; then
        exp_sec=$(date -d "$exp_date" +%s)
        now_sec=$(date +%s)
        if [[ $now_sec -ge $exp_sec ]]; then
            userdel -f "$user"
        fi
    fi
done
