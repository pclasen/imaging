#! /bin/csh -ef

#############################################
# Get onset times							#
# Usage: P1M1accOSTs.csh MIG <trim(sec)>	#
# Ex: P1M1accOSTs.csh MIG 8					#
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
		if (-d $on/P1/M1acc) then
		else
			cd $behave
			matlab -nodisplay -nojvm -nosplash -r "MIG_P1_onsets_M1acc('$sub',$trim);exit;" > $log
		endif

	end # for loop
endif
cd ~

# end