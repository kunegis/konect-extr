#!/usr/bin/perl
binmode(STDOUT, ":utf8");

opendir (in,"catster/cats/");
@cats=readdir(in);
closedir in;
opendir (in,"dogster/dogs/"),
@dogs=readdir(in);
closedir in;

foreach $cat(@cats){
	$cat="catster/cats/".$cat;
}
foreach $dog(@dogs){
	$dog="dogster/dogs/".$dog;
}

@petarray=(@cats,@dogs);

open F_OUT,">tmp/out.petster-familylinks-cat-dog";
print F_OUT "% sym unweighted\n";
print "checking\n";

open F_MD,">tmp/missingdogs.txt";
open F_MC,">tmp/missingcats.txt";
%mcats=();
%mdogs=();

foreach $petfile(@petarray){
	if ($petfile=~/(\d+)$/){
		$petid=$1;
		#print $petfile."\n";
		open F_IN,"<$petfile";
		while(<F_IN>){
			$line=$_;
			if ($line=~/<span class=subheader>Meet my family<\/span><br>(.*?)<\/table>/){
				$familyinfo=$1;
				#print $familyinfo;
				while($familyinfo=~/<a href="\/([^\/]*)\/(\d+)"/gi){
					#print $1."\n";
					if ((($1 eq "dogs") && (-e "dogster/dogs/$2"))||(-e "catster/cats/$2")){
						print F_OUT "$petid $2\n";
					}
					else{
					#print "petfile: $petfile\n";
						if($1 eq "dogs"){
							if (!(-e "dogster/dogs/$2")){
						#print F_MD "http://www.dogster.com/dogs/$2\n";
								print "dog: $2\n";
								$mdogs{"http://www.dogster.com/dogs/$2"}=1;
							}
						}elsif(!(-e "catster/cats/$2")){#print F_MC "http://www.catster.com/cats/$2\n";
								print "petfile: $petfile cat: $2\n";
								$mcats{ "http://www.catster.com/cats/$2"}=1;
	
							}
							
					}
				}
				last; 
			}


		}
		close F_IN;
	}
}
foreach $key(keys %mcats){
	print F_MC "$key\n";
}
foreach $key(keys %mdogs){
	print F_MD "$key\n";
}

close F_MD;
close F_MC;
close F_OUT;
exit;
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
