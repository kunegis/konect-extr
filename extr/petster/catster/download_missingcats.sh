#!/bin/bash
SET2=`ls cats/|sed 's/\(.*\)/http:\/\/www.catster.com\/cats\/\1/'`
SET1=`cat out/unique_friend_links`
#comm -23 <(sort $SET1) <(sort $SET2)
##echo -e "$SET2\n$SET2\n$SET1"|sort|uniq -u
#echo -e "$SET2\n$SET2\n$SET1"
#echo "--------------"
echo -e "$SET2\n$SET2\n$SET1"|sort|uniq -u>out/missingcats.txt
cd cats
#aria2c --allow-overwrite=false --auto-file-renaming=false -j10 -i../out/missingcats.txt
