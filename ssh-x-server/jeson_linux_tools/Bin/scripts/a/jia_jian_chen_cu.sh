echo "$1+$2=$(($1+$2))"
echo "$1-$2=$(($1-$2))"
echo "$1*$2=$(($1*$2))"
echo "$1/$2=$(($1/$2))"
echo "$1**$2=$(($1**$2))"
echo "$1%$2=$(($1%$2))"
a=$1
b=$2
echo "$1-=$2=$((a-=b))"
echo "$1++$2=$(($1++$2))"
