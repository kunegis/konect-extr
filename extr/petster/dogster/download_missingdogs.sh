#!/bin/bash
SET2=`ls dogs/|sed 's/\(.*\)/http:\/\/www.dogster.com\/dogs\/\1/'`
SET1=`cat out/unique_friend_links`
#comm -23 <(sort $SET1) <(sort $SET2)
##echo -e "$SET2\n$SET2\n$SET1"|sort|uniq -u
#echo -e "$SET2\n$SET2\n$SET1"
#echo "--------------"
echo -e "$SET2\n$SET2\n$SET1"|sort|uniq -u>out/missingdogs.txt
cd dogs
aria2c --allow-overwrite=false --auto-file-renaming=false -j10 -i../out/missingdogs.txt
