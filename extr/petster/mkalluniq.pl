#!/usr/bin/perl
my $dbg=0;
binmode(STDOUT, ":utf8");
require("sreadent.pl");
require("sreadhamsterent.pl");

sub pdebug{
	if($dbg){
		my $text=shift;
		print STDERR $text;
	}
}
sub save_ent{
	my $F_EP;

	my $pet_id=shift;
	my $path="testitnow";
	if ($entpath=~/hamster/){
		$path= "hamsterster/hamsters/$pet_id";
		if (-e $path){
			open $F_EP,">>$entpath";
			print $F_EP '"'.$ids[$pet_id].'" ';
			print $F_EP readhamsterent($path);
			close $F_EP;
			#system("echo \"".$ids{$pet_id}."\">>$entpath");
			#system("perl readhamsterent.pl \"$path\">>$entpath");
		}else{print "no hamsters: $path\n";}
	}else{
		if(-e "catster/cats/$pet_id"){
			$path="catster/cats/$pet_id";
		}else{$path="dogster/dogs/$pet_id";}
		 open $F_EP, ">>$entpath";
		 pdebug("starting readent");
		 print $F_EP readent($path,$is[$pet_id]);
		 pdebug("ending readent");
		 close $F_EP;
		 #system("perl readent.pl \"$path\" \"".$ids[$pet_id]."\">>$entpath");
	}
}
@ids=();
$current_id=1;
$arglen=@ARGV;
if ($arglen%2==0){
	print "good\n";
	for ($i=0;$i<$arglen;$i=$i+2){
		$files{$ARGV[$i]}=$ARGV[$i+1];
	}
}else{print "bad, number of arguments: $arglen\n";
	exit;
}


#exit;


#%files=(
#	"catster/out/out.petster-friendships-cat" => "out.petster-friendships-cat",
#    "dogster/out/out.petster-friendships-dog" => "out.petster-friendships-dog",
#	"tmp/out.petster-families-cat-dog" => "out.petster-families-cat-dog"
#);


foreach $key(keys %files){
my @ents=();
my $F_IN;
my $F_ENT;
my $F_OUT;
open $F_IN,"<".$key;
pdebug("infile: <".$key."\n");
open $F_OUT,">".$files{$key};

$entpath=$files{$key};
$entpath=~s/^out\./ent\./;
open $F_ENT,">$entpath";
if ($entpath=~/hamster/){
	print $F_ENT "%\n%\n% ent dat.name dat.joined dat.species dat.coloring dat.gender dat.birthday dat.age dat.hometown dat.favorite_toy dat.favorite_activity dat.favorite_food\n";
}else{
	print $F_ENT "%\n%\n% ent dat.name dat.home dat.weight dat.sex dat.race dat.species\n";
}
close $F_ENT;

while(my $line=<$F_IN>){
	#pdebug($line);
	if($line=~/^(\d+)\s+(\d+)$/){
		#pdebug($line);
		my $l=$1;
		my $r=$2;
		if(!defined $ids[$l]){$ids[$l]=$current_id;$current_id=$current_id+1;}
		#pdebug("step 1\n");
        if(!defined $ids[$r]){$ids[$r]=$current_id;$current_id=$current_id+1;}
		#pdebug("step 2\n");
		if(!defined $ents[$l]){save_ent($l);$ents[$l]=1;}
		#pdebug("step 3\n");
		if(!defined $ents[$r]){save_ent($r);$ents[$r]=1;}
		#pdebug("step 4\n");

		print $F_OUT $ids[$l]." ".$ids[$r]."\n";
		
	}else{
		print $F_OUT $line;
		print $line;
	}

}
pdebug("all done\n");
close $F_IN;
close $F_OUT;


}
