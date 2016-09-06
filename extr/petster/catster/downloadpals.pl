#!/usr/bin/perl
#$dog=$ARGV[0];

#open F_DOG,"<$dog";
system ("mkdir metalinks");
@metaarray=();
open F_PLINKS,">pallinks.txt";
#open F_METALINKS,">pals.metalink";
#print F_METALINKS '<?xml version="1.0" encoding="UTF-8"?>
#<metalink version="3.0" xmlns="http://www.metalinker.org">
#   <files>';
$metaHeader='<?xml version="1.0" encoding="UTF-8"?>
<metalink version="3.0" xmlns="http://www.metalinker.org">
   <files>';



print "generating metalink data\n";
opendir(my $dh, "cats") || die;
    foreach $dog(readdir($dh)){
	if ($dog=~/\./){next;}
	if (-e "pals/pals_$dog.1"){next;}
        #$dog="dogs/$dog";
	#print $dog."\n";
   
open F_DOG,"<cats/$dog";
$count="";
while(<F_DOG>){
	if ($_=~m#Friends:</span><a href="/friends_page.php\?c=(\d+)&i=(\d+)&#){
		$count=$1;
		$dog_id=$2;
	}
}
close F_DOG;
if ($count==""){
	print "error at cat $dog\n";
}
if ($count!= ""){#print "friends: $count\ndog: $dog_id\n";
#open F_PALS,">pals/$dog_id";


for ($i=1;($i-1)*50<$count;$i++){
	#print "$i\n";
	#"http://www.dogster.com/friends_page.php?p=2&c=79&i=147&n=&o=&u=#"
	$url="http://www.catster.com/friends_page.php?p=$i&amp;c=$count&amp;i=$dog_id&amp;n=&amp;o=&amp;u=#";
#	print F_METALINKS "	<file name=\"pals_$dog_id.$i\">\n
#		<resources>
#			<url type=\"http\">$url</url>
#		</resources>
#	</file>";
	push(@metaarray, " <file name=\"pals_$dog_id.$i\">\n
	       <resources>   
	           <url type=\"http\">$url</url>
	       </resources>
	   </file>");

	print F_PLINKS $url."\n";
	#open P_WGET,"wget -qO- \"$url\"|";
	#while(<P_WGET>){
	#	print F_PALS $_;
	#}
	#close P_WGET;
	
}


}
#close(F_PALS);
}



$metacount=0;
$linkcount=0;
system("rm metalinks/pals.*.metalink");
foreach $link(@metaarray){
	if ($linkcount==0){
		open F_METALINKS, ">metalinks/pals.$metacount.metalink";
		print F_METALINKS $metaHeader;
	}
	print F_METALINKS $link;
	$linkcount=$linkcount+1;
	if ($linkcount==10000){
		$metacount=$metacount+1;
		print F_METALINKS "  </files></metalink>";
		close F_METALINKS;
		$linkcount=0;

	}
	




}

if ($linkcount != 0){
	print F_METALINKS "  </files></metalink>";
	close F_METALINKS;
}


close F_PLINKS;
closedir $dh;
print "starting download\n";
#system("cd pals;aria2c --allow-overwrite=false --auto-file-renaming=false -j10 ../pals.metalink");
system('cd pals;for i in `ls ../metalinks/pals.*.metalink`; do aria2c --allow-overwrite=false --auto-file-renaming=false -j10 $i;done');
