#!/usr/bin/perl
use WWW::Mechanize;
$m = WWW::Mechanize->new();




$i=0;
while(true){
	$url="http://hamsterster.com/?x=pet_browse&skip=$i";
	print "Page $i\n";
	$m->get($url);
	$c = $m->content;
	#print $c;
	if($c=~/<a href="\/\?x=pet_browse&skip=([^"]+)"><img src="\/images\/nav_more.gif"/si){
#   if($c=~/<a href="(\/[^"]*)"/si){
   		print "found: $1\n";
		$i=$1;
		open F_OUT,">>ids.txt";
		while($c=~/<a href="\/\?pet=(\d+)">/g){
			print F_OUT "$1\n";

		}
		close F_OUT;
	}else{
		print "breaking\n";
		last;
		}
}
