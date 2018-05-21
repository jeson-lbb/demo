#!/bin/bash
read -p "one nuber [0-9]* :" sum
iff=$(($sum-1))
for((i=$sum,((k=$sum-1)),n=0;i>=1;i--,k--,((n=$n+2))))
	do 
	if [ $i -eq 1 ];then
		for z1 in `seq $((($sum*2-1)))`
		do echo -n "*"
		done	
	else
		for kp in `seq $k`	
		do echo -n " "
		done
		echo -n "*"

		if [ $i -le $iff ];then
		for z2 in `seq $(($n-1))`
		do echo -n " "
		done
		echo "*"
		else
			echo 
		fi	
	fi	
 done
echo 
#for((i=$sum,k=$sum,n=1;i>=1;i--,k--,n+=2));do for kp in `seq $k`;do echo -n " ";done;for zp in `seq $n`;do echo -n "*";done; echo; done
#for((i=$sum,k=0,((n=$sum*2-1));i>=1;i--,k++,n-=2));do for kp in `seq $k`;do echo -n " ";done;for zp in `seq $n`;do echo -n "*";done; echo; done 
#for((i=$sum,k=$sum,n=1;i>=1;i--,k--,n++));do for kp in `seq $k`;do echo -n " ";done;for zp in `seq $n`;do echo -n "* ";done; echo; done 
