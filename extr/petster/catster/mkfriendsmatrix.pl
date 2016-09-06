#!/usr/bin/perl


opendir (in,"pals/");
@pals=readdir(in);
closedir in;
open F_OUT,">out/out.petster-friendships-cat";
#open F_ENT,">out/ent.petster-friendships-cat";
print F_OUT "% sym unweighted\n";


#print F_ENT "%\n%\n% ent dat.name dat.home dat.weight dat.sex\n";


print "checking\n";
foreach $palsite(@pals){
	$path="pals/$palsite";
	#print "checking $path\n";
	if ($palsite=~/^pals_(\d+)\.(\d+)$/){
		$dog=$1;
#		$p_name="";
#		$p_home="";
#		$p_weight="";
#		$p_sex="";
		#print "	reading\n";
		open F_IN,"<$path";
		while(<F_IN>){
			$line=$_;
			#print $line;
			
			while ($line=~/<a href="\/cats\/(\d+)" target="*_top"*>/gi){
				if(-e "cats/$1"){
					print F_OUT "$dog $1\n";
				}
				#print "    $dog $1\n";
				
			}
			#$line=~s/&nbsp;//g;
#			if ($line=~/<span class="label">Home:<\/span>\s*([^<]*)/i){
#				$p_home=$1;
#			}
 #           if ($line=~/<span class="label">Weight:<\/span>\s*([^<]*)/i){
  #              $p_weight=$1;
   #         }
    #        if ($line=~/<span class="label">Sex:<\/span>\s*([^<]*)/i){
     #           $p_sex=$1;
	  #      }




			

		}

#        unless ($lastpet eq $dog){
#            print F_ENT "$dog \"$p_name\" \"$p_home\" \"$p_weight\" \"$p_sex\"\n";
#            print "$dog \"$p_name\" \"$p_home\" \"$p_weight\" \"$p_sex\"\n";
#        }



#		$lastpet=$dog;
#		close F_ENT;
		close F_IN;
	}
}
close F_OUT;
