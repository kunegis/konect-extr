#!/usr/bin/perl


open F_FILES,"<sitemap_dogster_index.xml";
my @lines=<F_FILES>;
close F_FILES;
foreach $line(@lines){
	if($line=~m#<loc>(.*)</loc>#){
		$url=$1;
		system("wget $url -o /dev/null");
		$url=~/.*\/([^\/]*)/;
		$filename=$1;
		#print "filename: $filename\n";
		open P_LIST, "gunzip -c $filename|";
		while(<P_LIST>){
			if ($_=~m#<loc>(.*)</loc>#){
				$link=$1;
				if ($link=~/http:\/\/www.dogster.com\/dogs\/([0-9]+)$/){
					print "$link\n";
				}
			}

		}
	}
}
