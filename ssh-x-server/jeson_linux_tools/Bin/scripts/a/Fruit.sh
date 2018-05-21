#!/bin/bash
Red="\e[31m"
Green="\e[32m"
Yellow="\e[33m"
Blue="\e[36m"
Rst="\e[0m"
clear
Menu(){
      echo -e "
#############$Rst$Yellow--MENU--$Rst#############        
      1)$Red apple$Rst        
      2)$Green pear$Rst        
      3)$Yellow banana$Rst    
      4)$Blue cherry$Rst     
      0) exit         
##################################"
}
fult(){
  read -p "Please Check The Name:" ans
  clear
  echo
  case "$ans" in
       1)
       echo -e "You Check The$Red apple$Rst"
       ;;
       2)
       echo -e "You Check The$Green pear$Rst"
       ;;
       3)
       echo -e "You Check The $Yellow banana$Rst"
       ;;
       4)
       echo -e "You Check The $Blue cherry$Rst"
       ;;
       0)
       exit 1
       ;;
      *)
       echo -e "\e[34;5mYou No Check The Shui Gou!\e[0m "
  esac
}
Main(){
    while true ;do
       Menu
       fult
    done
}
Main
