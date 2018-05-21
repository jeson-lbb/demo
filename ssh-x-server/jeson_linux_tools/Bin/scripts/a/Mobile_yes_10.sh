#!/bin/bash
clear
Red_5="\e[31;5m"
Red="\e[31m"
Green="\e[32m"
Yellow="\e[33m"
Blue="\e[34m"
Purple="\e[35m"
Rst="\e[0m"
# echo -e "$ $Rst"
echo -e "$Yellow Your mobile heve 10$ !$Rst"
Bal="1000"
send()
{
	read -p "Send your messege:" Mess
	echo -e "$Yellow you menssege is :$Rst $Green $Mess $Rst"
	((Bal-=15))
	echo -e " $Yellow You balance is =$Rst $Red `echo $Bal|awk '{ print $1/100 }'`$Rst"
  if [ $Bal -lt 15 ];then
     {
        echo -e "$Red_5 sorry no money!$Rst"
        read -p "You balance bu zhu ,Pls zhu zhi: " Ball
	  if [[ $Ball != 0 ]] ;then
	    {
	       Ball=`echo -e $Ball|awk '{ print $1*100 }'`
	       ((Bal+=Ball))
	       echo -e " $Yellow You balance is =$Rst $Red `echo $Bal|awk '{ print $1/100 }'`$Rst"
	    } 
	  fi
     }
  fi
}
Main(){
     while true
     do 
     send
     done
}
Main
