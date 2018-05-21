#!/bin/bash
Red="\e[31;5m"
Green="\e[32m"
Yellow="\e[33m"
Blue="\e[34m"
Purple="\e[35m"
Rst="\e[0m"

# echo -e -e "$ $Rst"
                  
 Ji_num="0"
Input_Num(){
   read -p "Please Input Tow(50) Chars:" num char
   Char=$char
   expr "$num" + 1 &>/dev/null
   RETVAL=$?
   if [ -z "$Char" -a -z "$num" ];then
       echo -e "$Yellow Please Input Tow(50) Chars: {[0-9]*2  da|xiao|deng}$Rst"
    elif [ "$RETVAL" -ne 0 ] ;then
       echo -e "$Yellow The First is not int : {[0-9]*2  da|xiao|deng}$Rst"
    elif [ "$Char" != "da" -a "$Char" != "deng" -a "$Char" != "xiao" ];then
       echo -e "$Yellow The Second is not char : {[0-9]*2  da|xiao|deng}$Rst"
    else
           Sta_Num=`echo -e "$RANDOM"|awk -F "" '{print $(NF-1)$NF}'`
       if [[ "$num" > "$Sta_Num" && "$Char" == "da" ]];then
	   echo -e "$Blue $num > $Sta_Num $Rst"
	   Ji_num="0"
       elif [[ "$num" < "$Sta_Num" && "$Char" == "xiao" ]];then
           echo -e "$Blue $num < $Sta_Num $Rst"
	   Ji_num="0"
       elif [[ "$num" -eq "$Sta_Num" && "$Char" == "deng" ]];then
           echo -e "$Blue $Sta_Num = $num $Rst"
	   Ji_num="0"
       else
	   ((Ji_num+=1))
           echo -e "$Blue You not cai dui ,Please still $Rst $Green+($Ji_num)+ is[$Sta_Num] $Rst"
       fi
   fi
}
Main(){
      while true
      do
        Input_Num
      done
}
Main
