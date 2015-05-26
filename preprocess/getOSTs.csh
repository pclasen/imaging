#! /bin/csh -ef

#############################################
# Get onset times							#
# Usage: getOSTs.csh <study> <trim(sec)>	#
# Ex: getOSTs.csh MIG 8						#
# p.clasen									#
#############################################

# define
set DIR = ~/Documents/$1
set trim = $2 
set file = $DIR/doc/asublist.txt
set behave = ~/imaging/behavior
set log = $DIR/doc/junk.txt

if ($1 == MIG) then
	foreach line ("`cat $file`")

		set sub = "$line"
		set be = $DIR/$sub/be
		set on = $be/onsets

		# phase 1 - model 1 (event related)
		if (-d $on/P1/M1) then
		else
			cd $behave
			matlab -nodisplay -nojvm -nosplash -r "MIG_P1_onsets_M1('$sub',$trim);exit;" > $log
		endif

		# phase 1 - model 2 (block design)
		if (-d $on/P1/M2) then
		else
			cd $behave
			matlab -nodisplay -nojvm -nosplash -r "MIG_P1_onsets_M2('$sub',$trim);exit;" > $log
		endif

		# phase 2 - model 1 (1 second uniform durations)
		if (-d $on/P2/M1) then
		else
			cd $behave
			matlab -nodisplay -nojvm -nosplash -r "MIG_P2_onsets_M1('$sub',$trim);exit;" > $log
		endif

		# phase 2 - model 2 (durations locked to actual event times)
		if (-d $on/P2/M2) then
		else
			cd $behave
			matlab -nodisplay -nojvm -nosplash -r "MIG_P2_onsets_M2('$sub',$trim);exit;" > $log
		endif

	end # for loop
endif
cd ~

# end