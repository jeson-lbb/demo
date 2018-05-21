#!/bin/bash
Path="/root/oldboy"
[ ! -d "$Path" ]&&mkdir "$Path"
Touch(){
	cd "$Path"
	rm -f *.*
	for((n=1;n<=10;n++))
	do
   	  touch "$Path"/oldboy_"$n".html
	done
}
Rename(){
	cd "$Path"
	for file in `ls *.html`
	do
  	mv "$file" `echo "$file"|sed -r 's/^.+(_[0-9]+\.).+$/linux\1txt/'`
	done
}
Adduser(){
	for User in $(seq -w 10) 
	do
	  userdel oldboy$User
	  Passwd=`echo ${RANDOM}|md5sum|tr [a-z] [0-9]|cut -c 2-9`
	  useradd oldboy$User
	  echo "$Passwd"|passwd --stdin oldboy$User
	  echo -e "oldboy$User\t$Passwd" >>/tmp/UserPasswd.log
	done
}
Main(){
	Touch
	Rename
}
