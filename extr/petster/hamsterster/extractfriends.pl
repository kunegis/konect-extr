#! /usr/bin/perl
#
# INPUT 
#	Everything in the directory hamsters/
# 
# OUTPUT
#	out.petster-friendships-hamster
#

opendir(in,"hamsters/");
@hamsters = readdir(in);
closedir in;
open F_FAMILY_OUT,">out.petster-friendships-hamster";
print F_FAMILY_OUT "% sym unweighted\n";

foreach $id(@hamsters) {
    $hamsterfile="hamsters/$id";
    open F_IN,"<$hamsterfile";
    $data=join("", <F_IN>); 
    close F_IN;

    if ($data=~/alt="my friends">(.*?)<\/center>/si) {
	$familydata=$1;
	while ($familydata=~/<a href="\/\?pet=(\d+)">/gsi) {
	    print F_FAMILY_OUT "$id $1\n";
	}
    }
}


