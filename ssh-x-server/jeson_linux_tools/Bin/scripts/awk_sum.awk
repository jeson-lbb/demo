awk -F " " '{ar[$2]=ar[$2]+1}END{for(k in ar)print k,ar[k]}' hosts 
