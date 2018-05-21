awk '/\.(jpg|js)/{ar[$7]++;arr[$7]+=$10}END{for(n in ar)print ar[n],arr[n],n}' access_2010-12-8.log
