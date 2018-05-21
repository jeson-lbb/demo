#!/bin/bash
#Date:   01:17 2018-01-24 
#Author: Created by leeth
#Mail:   309769163@qq.com
#Funcsion:This scripts funcsion is files rename "*_oldboy.html to *_oldgirl.HTML" in "/oldboy/" directory
#Version:1.1
Path="/oldboy/"
if [ -d $Path ]     # Find /oldboy/ directory? ( yes or no )
   then      
       if expr `ls "$Path"|wc -l` = 0 &>/dev/null # Find directory /oldboy/'s has files?  ( yes or no )
          then
               echo "\"$Path\" is no Files!"
	       exit 11
       else
	     if expr `ls "$Path"|grep -E "^.*html$"|tail -1` : ".*\.html" &>/dev/null # Find /oldboy/'s files is *.html? ( yes or no )
		then  	
 	            for n in `ls ${Path}*.html`
	            do
                       rename "oldboy.html" "oldgirl.HTML" ${n} 
		       echo "${n}"' ===>' is renaming  to' ===>' `ls ${Path}*.HTML|tail -1 `
		       echo 'Press Ctrl+C to exit !'
                       ii=`ls ${Path}*.*|wc -l`
  		       i=`ls ${Path}*.HTML|wc -l`
  		       echo sheng yu files==\> ${ii}-${i}\=$((ii - i))
  		       sleep 3
  		    done
		       echo "You rename is OK!"
	               exit 13
	     else
		       echo "No such \"${Path}*.html\" Files!"
		       exit 12
	     fi	
       fi
else
    echo "No such \"${Path}\" directory!"
    exit 10
fi
