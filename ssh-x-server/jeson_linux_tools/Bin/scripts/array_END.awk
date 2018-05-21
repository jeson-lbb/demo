awk 'BEGIN{array[1]="oldboy";array[2]="jeson";}END {for(key in array) print key,array[key];}' /etc/hosts
cat /etc/hosts|awk 'BEGIN{array[1]="oldboy";array[2]="jeson";}END {for(key in array) print key,array[key];}'
awk '{ar[$1]=$2}END{for(key in ar)print key" ===",ar[key]}' /etc/hosts
