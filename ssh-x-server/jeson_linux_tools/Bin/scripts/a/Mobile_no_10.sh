#!/bin/bash
Red="\e[31;5m"
Green="\e[32m"
Yellow="\e[33m"
Blue="\e[34m"
Purple="\e[35m"
Rst="\e[0m"
# echo -e -e "$ $Rst"
clear
echo -e "$Yellow Your mobile heve 10$ !$Rst"
Bal="1000"
send()
{
  if [ $Bal -ge 15 ];then
     {
	read -p "Send your messege:" Mess
	echo -e "$Green you menssege is :$Rst $Mess"
	echo -e "$Yellow  You balance is =$Rst $Red `echo -e $((Bal-15))|awk '{ print $1/100 }'`$Rst"
	Bal=$((Bal-15))
     }
  else
     {
        read -p " You balance bu zhu ,Pls zhu zhi:" Ball
	  if [[ $Ball != 0 ]] ;then
	    {
	       Ball=`echo -e $Ball|awk '{ print $1*100 }'`
	       Bal=$(($Ball+$Bal))
	    } 
          fi
	echo -e " $Yellow You balance is =$Rst $Red`echo -e $Bal|awk '{ print $1/100 }'`$Rst"
	  if [ $Bal -lt 15  ];then
	    {
          	echo -e "$Red sorry no money!$Rst"
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
