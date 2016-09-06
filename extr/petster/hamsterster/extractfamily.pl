#!/usr/bin/perl
opendir(in,"hamsters/");
@hamsters=readdir(in);
closedir in;
open F_FAMILY_OUT,">out.petster-familylinks-hamster";
print F_FAMILY_OUT "% sym unweighted\n";
foreach $id(@hamsters){
	$hamsterfile="hamsters/$id";
	open F_IN,"<$hamsterfile";
	$data=join("", <F_IN>); 
	close F_IN;
	#print $data;
	if($data=~/alt="my family">(.*?)<\/center>/si){
		$familydata=$1;
		while($familydata=~/<a href="\/\?pet=(\d+)">/gsi){
			print F_FAMILY_OUT "$id $1\n";
		}
	}
}


