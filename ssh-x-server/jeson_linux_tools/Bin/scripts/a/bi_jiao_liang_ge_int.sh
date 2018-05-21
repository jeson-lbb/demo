#!/bin/bash
read -p "Please input tow int:" a b
if [ "$a" -eq "$b" &>/dev/null ] ;then
    echo "$a"'='"$b"
else
  if  [ "$a" -ge 0 &>/dev/null -a "$b" -ge 0 &>/dev/null ] ;then

      [ "$a" -gt "$b" ] && echo "$a"'>'"$b" || echo "$b"'>'"$a"
  else
       [ "$a" -ge 0 &>/dev/null ] || echo "$a is not int"
       [ "$b" -ge 0 &>/dev/null ] || echo "$b is not int"
  fi
fi
