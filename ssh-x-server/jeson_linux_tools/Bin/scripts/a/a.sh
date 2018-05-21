for n in `awk '{print $1}' a.txt`
do
	va=$(echo  "$n `grep "$n" a.txt|awk '{ sum += $2 }; END { print sum }'` ")
	val=$val$va
done
echo "$val"|xargs -n 2|sort|uniq 
