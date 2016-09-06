#!/usr/bin/perl


opendir (in,"pals/");
@pals=readdir(in);
closedir in;
open F_OUT,">out/friends";
print "checking\n";
foreach $palsite(@pals){
	$path="pals/$palsite";
	#print "checking $path\n";
	if ($palsite=~/^pals_(\d+)\.(\d+)$/){
		$dog=$1;
		#print "	reading\n";
		open F_IN,"<$path";
		while(<F_IN>){
			$line=$_;
			#print $line;
			while ($line=~/<a href="\/cats\/(\d+)" target="*_top"*>/gi){
				print F_OUT "$dog $1\n";
				#print "    $dog $1\n";
				
			}

		}
		close F_IN;
	}
}
close F_OUT;
system("cd out;cat friends|sed 's/.* \\(.*\\)/http:\\/\\/www.catster.com\\/cats\\/\\1/'|sort|uniq>unique_friend_links");
