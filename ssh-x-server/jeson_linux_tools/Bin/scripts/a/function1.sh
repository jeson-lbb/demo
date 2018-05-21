Url()
{
   if [ -f "$1" ];then
     {
        echo  "$1"  is find!
     }
   else
     {
	echo no find "$1"
     }
   fi
}
Url "$1"
