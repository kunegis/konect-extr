#!/bin/bash
for i in `seq 107 1000`; do  
	sleep 3; 
	#wget -U "links" "http://www.google.com/search?q=site:catster.com+inurl:catster.com/cats/&start=$i" -O google/$i.html;
	wget -U "Opera" "http://www.google.com/search?client=opera&rls=de&q=site:catster.com+inurl:catster.com/cats/&sourceid=opera&ie=utf-8&oe=utf-8&channel=suggest#q=site:catster.com+inurl:catster.com/cats/&hl=en&client=opera&hs=hnJ&rls=de&channel=suggest&prmd=imvns&ei=9iWCTriXHun14QTK8qB_&start=$i&sa=N&bav=on.2,or.r_gc.r_pw.&fp=e72fd7976064f6ec&biw=1105&bih=914" -O google/$i.html;
	
done
