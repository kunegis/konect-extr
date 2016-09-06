#!/usr/bin/perl
#
# Usage: mkent.pl <profile file>
# 
# Output one line of the ent.* file on STDOUT. 
#

open F_IN,"<".$ARGV[0] or die "could not open file: ".$ARGV[0]."\n";
$args=@ARGV;

$p_id="";
$p_name="";
$p_home="";
$p_weight="";
$p_sex="";
$p_race="";
$p_species="";

while(<F_IN>){
    $line=$_;

    $line=~s/&nbsp;//g;
    if ($line=~/<span class="label">Home:<\/span>\s*([^<]*[^< ])/i){
	$p_home=$1;
    }else{}

    if ($line=~/<span class="label">Weight:<\/span>\s*([^<]*[^< ])/i){
	$p_weight=$1;
    }
    if ($line=~/<span class="label">Sex:<\/span>\s*([^<]*[^< ])/i){
	$p_sex=$1;
    }
    if($line=~/"\/gifts\/\?recipient=pet:(\d+)"/){
	$p_id=$1;
    }
    if($line=~/<title>(Cat|Dog) profile for ([^<]*), a (female|male) ([^<]*)<\/title>/i) {
	$p_species=$1;
	$p_name=$2;
	$p_race=$4;
    }
}

if ($args>0){$p_id=$ARGV[1];}
$p_name=~s/\\/\\\\/g;
$p_name=~s/"/\\"/g;
$p_weight=~s/\\/\\\\/g;
$p_weight=~s/"/\\"/g;
$p_home=~s/\\/\\\\/g;
$p_home=~s/"/\\"/g;

$p_sex=~s/\\/\\\\/g;
$p_sex=~s/"/\\"/g;

$p_race=~s/\\/\\\\/g;
$p_race=~s/"/\\"/g;
$p_species=~s/\\/\\\\/g;
$p_species=~s/"/\\"/g;

print "$p_id \"$p_name\" \"$p_home\" \"$p_weight\" \"$p_sex\" \"$p_race\" \"$p_species\"\n";




