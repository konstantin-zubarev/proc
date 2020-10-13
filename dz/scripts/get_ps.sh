#!/usr/bin/env bash

psname(){
        pidname=$(grep "^Name:" /proc/$pid/status | awk '{print $2}')
        echo $pidname
}



psstatus(){
        procstatus=$(grep "State:" /proc/$pid/status | awk '{print $2, $3}')
        echo $procstatus
}

pscommand(){
        com=$(sed -e 's/\x00/ /g' -e 's!$!\n!' /proc/$pid/cmdline)
        echo $com
}


allpids=$(ls /proc | grep -E '^[0-9]+$' | sort -n)
printf "%-8s %-17s %-20s %s\n" "PID" "NAME" "STAT" "COMMAND"
for pid in $allpids; do
        if [ -e /proc/$pid ];then
                printf "%-8s %-17s %-20s %s\n" "$pid" "$(psname)" "$(psstatus)" "$(pscommand)"
        fi
done

