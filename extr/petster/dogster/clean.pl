#!/usr/bin/perl
$list1= $ARGV[0];
$list2= $ARGV[1];
my %check=();


open F_LIST1,"<$list1";
my @lines=<F_LIST1>;
close F_LIST1;
open F_LIST2,"<$list2";
my @lines2=<F_LIST2>;
close F_LIST2;
foreach $line(@lines2){
	chomp($line);
}
foreach $line(@lines){
	chomp($line);
	$check{$line}=1;
#	print $line;
}
foreach $key(keys %check){
	print $key;
}
foreach $line(@lines2){
#	if (exists $check{$line}){
		delete $check{$line};
#	}
}
foreach $key(keys %check){
	print $key;

}




