#!/usr/bin/perl
#
# usage: mkent.pl <profile file>
#
#open $F_IN,"<".$ARGV[0] or die "could not open file: ".$ARGV[0]."\n";
#$args=@ARGV;

#print F_ENT "%\n%\n% ent dat.name dat.home dat.weight dat.sex dat.race dat.species\n";
sub readent{
	my ($file,$id)=@_;
	my 	 $p_id="";
    my   $p_name="";
    my   $p_home="";
    my   $p_weight="";
    my   $p_sex="";
	my    $p_race="";
	my   $p_species="";
        #print "    reading\n";
		my $F_IN;
        open $F_IN,"<$file";
        while(<$F_IN>){
           my $line=$_;
            #print $line;

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
		if($line=~/<title>(Cat|Dog) profile for ([^<]*), a (female|male) ([^<]*)<\/title>/i){
			$p_species=$1;
			$p_name=$2;
			$p_race=$4;
		}




        }

#        unless ($lastpet eq $dog){
#            print F_ENT "$dog \"$p_name\" \"$p_home\" \"$p_weight\" \"$p_sex\"\n";
		if ($id ne ""){$p_id=$id;}
		#if ($args>0){$p_id=$ARGV[1];}
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



            return "$p_id \"$p_name\" \"$p_home\" \"$p_weight\" \"$p_sex\" \"$p_race\" \"$p_species\"\n";
#        }
}

return 1;
