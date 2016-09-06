#!/usr/bin/perl
use File::Copy;
opendir (in,"dogs/");
@dogs=readdir(in);
closedir in;
foreach $dog(@dogs){
	if($dog=~/\d+/){
		open F_DOG,"<dogs/$dog";
		my $lines=join("",<F_DOG>);
		close F_DOG;
		if ($lines=~/<meta.*Catster profile.*/g){
			print "$dog\n$0\n";
			move("dogs/$dog","cats/$dog");
		}
	}
}
