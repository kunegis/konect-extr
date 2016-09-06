#!/usr/bin/perl
$path=$ARGV[0];
open $F_IN,"<$path" or die "could not open $path\n";
@lines=<$F_IN>;
close $F_IN;
$line=join("",@lines);
$line=~s/[\r\n]//gm;
$line=~/<div class="big">\s*([^<]*)<br>/i;
$name= $1;
$line=~/<b>Member Since<\/b>:\s*([^<]*)<br>/i;
$joined=$1;
$line=~/<b>Species<\/b>:\s*(.*?)<br>/;
$species=$1;
$species=~s/<[^>]*>//g;
$line=~/<b>Coloring<\/b>:\s*([^<]*)<br>/;
$coloring=$1;
$line=~/<b>Gender<\/b>:\s*([^<]*)<br>/;
$gender=$1;
$line=~/<b>Birthday<\/b>:\s*([^<]*)<br>/;
$birthday=$1;
$line=~/<b>Age<\/b>:\s*([^<]*)<br>/;
$age=$1;
$line=~/<b>Hometown<\/b>:\s*([^<]*)<br>/;
$hometown=$1;
$line=~/<b>Favorite Toy<\/b>:\s*([^<]*)<br>/;
$favorite_toy=$1;
$line=~/<b>Favorite Activity<\/b>:\s*([^<]*)<br>/;
$favorite_activity=$1;
$line=~/<b>Favorite Food<\/b>:\s*([^<]*)<br>/;
$favorite_food=$1;

#$line=
print "\"$name\" \"$joined\" \"$species\" \"$coloring\" \"$gender\" \"$birthday\" \"$age\" \"$hometown\" \"$favorite_toy\" \"$favorite_activity\" \"$favorite_food\"\n";
#        print F_ENT "%\n%\n% ent dat.name dat.joined dat.species dat.coloring dat.gender dat.birthday dat.age dat.hometown dat.favorite_toy dat.favorite_activity dat.favorite_food\n";

