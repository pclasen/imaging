#! /bin/csh -ef

#########################################
# organize behavioral data              #
# Usage: ./beORG.csh <study>			#
# Ex:	 ./beORG.csh MIG				#
# p.clasen								#
#########################################

set DIR = ~/Documents/$1
set file = $DIR/doc/asublist.txt

if ($1 == MIG) then
	foreach line ("`cat $file`")
		
		set sub = "$line"
		set be = $DIR/$sub/be

		if (-d $be/raw) then
		else
			mkdir $be/raw
			mv $be/*.mat $be/raw
			mv $be/*.txt $be/raw
		endif 

		if (-d $be/clean) then
		else
			mkdir $be/clean
			mkdir $be/clean/P1
			mkdir $be/clean/P2
			mkdir $be/clean/P3
		endif

		if (-d $be/onsets) then
		else 
			mkdir $be/onsets
			mkdir $be/onsets/P1
			mkdir $be/onsets/P2
		endif

	end # for 
endif

if ($1 == RAP) then
	foreach line ("`cat $file`")
		
		set sub = "$line"
		set be = $DIR/$sub/be

		if (-d $be/raw) then
		else
			mkdir $be/raw
			mv $be/*.mat $be/raw
			mv $be/*.txt $be/raw
		endif 

		if (-d $be/clean) then
		else
			mkdir $be/clean
		endif

		if (-d $be/onsets) then
		else 
			mkdir $be/onsets
		endif

	end # for 
endif

# end