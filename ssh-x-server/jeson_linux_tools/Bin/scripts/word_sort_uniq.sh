#!/bin/bash
document=$1
#sed -r 's/\W*|[_0-9]*/ /g' $document|xargs -n 1|sort|uniq -c|sort -nr -k1
sed -r 's/\W+|[_0-9]+/ /g' $document|xargs -n 1|sort|uniq -c|sort -nr -k1
#sed -r 's/\W+|[_0-9]+/\n/g' $document|sort|uniq -c|sort -nr -k1
