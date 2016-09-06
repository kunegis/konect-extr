#!/usr/bin/perl

sub readhamsterent{
	
my $path=shift;
my $F_IN;
open $F_IN,"<$path" or die "could not open $path\n";
my @lines=<$F_IN>;
close $F_IN;
my $line=join("",@lines);
$line=~s/[\r\n]//gm;
$line=~/<div class="big">\s*([^<]*)<br>/i;
my $name= $1;
$line=~/<b>Member Since<\/b>:\s*([^<]*)<br>/i;
my $joined=$1;
$line=~/<b>Species<\/b>:\s*(.*?)<br>/;
my $species=$1;
$species=~s/<[^>]*>//g;
$line=~/<b>Coloring<\/b>:\s*([^<]*)<br>/;
my $coloring=$1;
$line=~/<b>Gender<\/b>:\s*([^<]*)<br>/;
my $gender=$1;
$line=~/<b>Birthday<\/b>:\s*([^<]*)<br>/;
my $birthday=$1;
$line=~/<b>Age<\/b>:\s*([^<]*)<br>/;
my $age=$1;
$line=~/<b>Hometown<\/b>:\s*([^<]*)<br>/;
my $hometown=$1;
$line=~/<b>Favorite Toy<\/b>:\s*([^<]*)<br>/;
my $favorite_toy=$1;
$line=~/<b>Favorite Activity<\/b>:\s*([^<]*)<br>/;
my $favorite_activity=$1;
$line=~/<b>Favorite Food<\/b>:\s*([^<]*)<br>/;
my $favorite_food=$1;

#$line=
return "\"$name\" \"$joined\" \"$species\" \"$coloring\" \"$gender\" \"$birthday\" \"$age\" \"$hometown\" \"$favorite_toy\" \"$favorite_activity\" \"$favorite_food\"\n";
#        print F_ENT "%\n%\n% ent dat.name dat.joined dat.species dat.coloring dat.gender dat.birthday dat.age dat.hometown dat.favorite_toy dat.favorite_activity dat.favorite_food\n";
}
return 1;
