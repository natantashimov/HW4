#!/bin/bash
wget https://www.ynetnews.com/category/3082
grep -o "https://www.ynetnews.com/article/........." 3082 | sort |uniq >output.txt
mkdir ynet
mv output.txt ynet
cd /home/mamat/ynet/
wget -i output.txt
mv output.txt /home/mamat
for FILE in *;do grep -o -E 'Netanyahu' $FILE |wc -l ;done >/home/mamat/netanyahu_list.txt
for FILE in *;do grep -o -E 'Gantz' $FILE | wc -l ;done >/home/mamat/gantz_list.txt
cd /home/mamat/
cat output.txt > comb.txt
cat netanyahu_list.txt >> comb.txt
cat gantz_list.txt >> comb.txt
awk ' {val[NR]=$0}                                                          \
END {                                                                       \
      row=NR/3      ;   print row ;                                         \   
      for ( i=1 ; i<=row; ++i )                                             \
      {                                                                     \             
     if (val[i+row]!=0 || val[i+2*row]!=0 )                                 \
    { print val[i]"," " Netanyhu,",val[i+row]",","Gantz,",val[i+row*2] ; }  \
     else                                                                   \ 
         { print val[i]",""-" ; }                                           \ 
      }                                                                     \
      }' comb.txt | cat >results.csv