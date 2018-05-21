#!/bin/awk
BEGIN{
array[1]="oldboy"
array[2]="oldgirl"
array[3]="jeson"
for(key in array)
print key,array[key]
}
#awk -f t2.awk
