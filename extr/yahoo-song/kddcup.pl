#!/usr/bin/perl
#$datei="track1/trainIdx1.txt";;
$datei=$ARGV[0];
open(IN,'<'.$datei) || die "Can not open file $datei: $!";
$userid=-1;
$maxnum=0;
$currentnum=0;

while(<IN>){
	$line=$_;
	
	if($line=~/(\d+)\|(\d+)/){
		$userid=$1;
		if($maxnum!=$currentnum){die "number of ratings not as expected\nuserid:$userid";}
		#print  $line;
		$maxnum=$2;
		$currentnum=0;	
	}elsif($line=~/(\d+)\t(\d+)\t(\d+)\t(\d\d):(\d\d):(\d\d)/){
		$currentnum++;
		if($maxnum<$currentnum){die "number of ratings too high\n";}
		#print $line;
		$time=$3*24*60*60 + $4*3600 + $5*60 + $6;
		print "$userid $1 $2 $time\n";
	}elsif($line=~/(\d+)\t(\d+)/){
		$currentnum++;
		if($maxnum<$currentnum){die "number of ratings too high\n";}
		print "$userid $1 $2\n";
	}



}
